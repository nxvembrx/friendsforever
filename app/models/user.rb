require 'digest'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 1, maximum: 30 }, format: { with: /\A[a-zA-Z\d_]+\z/, message: "only letters, numbers, and underscores" }

  has_many :memos
  has_many :bookmarks
  has_many :bookmarked_memos, through: :bookmarks, source: :memo
  has_one :profile

  after_create :create_profile

  def hashed_email
    Digest::SHA256.hexdigest(email)
  end

  private

  def create_profile
    create_profile!
  end
end
