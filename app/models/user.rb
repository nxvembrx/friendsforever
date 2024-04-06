require 'digest'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 1, maximum: 30 }, format: { with: /\A[a-zA-Z\d_]\z/, message: "only letters, numbers, and underscores" }
  validates :location, length: { maximum: 30 }
  validates :website, length: { maximum: 35 }
  validates :pronouns, length: { maximum: 30 }
  validates :bio, length: { maximum: 350 }

  has_many :memos

  def hashed_email
    Digest::SHA256.hexdigest(email)
  end
end
