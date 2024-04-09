# frozen_string_literal: true

require 'digest'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 1, maximum: 30 },
            format: { with: /\A[a-zA-Z\d_]+\z/, message: 'only letters, numbers, and underscores' }

  has_many :memos
  has_many :bookmarks
  has_many :bookmarked_memos, through: :bookmarks, source: :memo
  has_one :profile
  # Friendship modeled after `power_of_friendship` by LelandCer
  # https://github.com/LelandCer/power_of_friendship
  has_many :approved_friendships,
           -> { where('user_friendships.pending' => false) },
           foreign_key: :user_id,
           class_name: 'UserFriendship'
  has_many :friends,
           through: :approved_friendships,
           source: :friend
  has_many :friendships,
           foreign_key: :user_id,
           class_name: 'UserFriendship',
           dependent: :destroy
  has_many :invited_friends,
           through: :invited_friendships,
           source: :friend
  has_many :invited_friendships,
           -> { where('user_friendships.pending' => true) },
           foreign_key: :user_id,
           class_name: 'UserFriendship'
  has_many :pending_friends,
           -> { where('user_friendships.pending' => true) },
           through: :pending_friendships,
           source: :user
  has_many :pending_friendships,
           -> { where('user_friendships.pending' => true) },
           foreign_key: :friend_id,
           class_name: 'UserFriendship'

  after_create :create_profile

  def hashed_email
    Digest::SHA256.hexdigest(email)
  end

  def invite(friend)
    return false if friend == self || find_any_friendship_with(friend)

    UserFriendship.new(user_id: id, friend_id: friend.id, pending: true).save
  end

  def approve(friend)
    friendship = UserFriendship.where(user_id: friend.id, friend_id: id, pending: true).first
    return false if friendship.nil?

    if friendship.update_attribute(:pending, false)
      create_complimentary_friendship friendship
      true
    else
      false
    end
  end

  def unfriend(friend)
    friendship = find_any_friendship_with friend
    return true unless friendship

    friendship.destroy
    destroy_complimentary_friendship friendship
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def connected_with?(user)
    find_any_friendship_with(user).present?
  end

  def invited_by?(user)
    friendship = find_any_friendship_with(user)
    return false if friendship.nil?
    return friendship.send(:user_id) == user.id if friendship.pending == true

    inverse_friendship = find_friendship_complement friendship
    return friendship.send(:user_id) == user.id if friendship.created_at <= inverse_friendship.created_at

    inverse_friendship.send(:user_id) == user.id
  end

  def invited?(user)
    friendship = UserFriendship.where(user_id: id, friend_id: user.id).first
    return false if friendship.nil?
    return friendship.friend_id == user.id if friendship.pending == true

    inverse_friendship = find_friendship_complement friendship
    return friendship.friend_id == user.id if friendship.created_at <= inverse_friendship.created_at

    inverse_friendship.friend_id == user.id
  end

  # TODO: Suggested friends?

  def create_complimentary_friendship(friendship)
    return false if friendship.pending?

    UserFriendship.create(user_id: friendship.friend_id,
                          friend_id: friendship.send(:user_id), pending: false)
  end

  def destroy_complimentary_friendship(friendship)
    return false if friendship.pending?

    friendship_compliment = find_friendship_complement friendship
    friendship_compliment.destroy
  end

  def find_friendship_complement(friendship)
    UserFriendship.where(user_id: friendship.friend_id,
                         friend_id: friendship.send(:user_id)).first
  end

  def find_any_friendship_with(user)
    UserFriendship.where(
      user_id: id,
      friend_id: user.id
    ).or(
      UserFriendship.where(
        user_id: user.id,
        friend_id: id
      )
    ).order(created_at: :desc).first
  end

  private

  def create_profile
    create_profile!
  end
end
