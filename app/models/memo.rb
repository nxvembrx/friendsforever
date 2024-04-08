class Memo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  validates :body, presence: true, length: { minimum: 1, maximum: 500 }

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def bookmark_of(user)
    bookmarks.find_by(user_id: user.id)
  end

end
