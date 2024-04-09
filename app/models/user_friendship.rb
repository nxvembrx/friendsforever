class UserFriendship < ApplicationRecord
  belongs_to :user

  belongs_to :friend,
             class_name: 'User',
             foreign_key: :friend_id

  validates_presence_of :friend_id, :user_id
  validates_uniqueness_of :user_id, scope: :friend_id

  def approved?
    !pending
  end

  def pending?
    pending
  end
end
