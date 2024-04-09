class Profile < ApplicationRecord
  belongs_to :user

  before_update :strip_website

  validates :display_name, length: { maximum: 50 }
  validates :location, length: { maximum: 40 }
  validates :website, length: { maximum: 50 }
  validates :pronouns, length: { maximum: 40 }
  validates :bio, length: { maximum: 400 }

  private

  def strip_website
    self.website = website.gsub(%r{\A\s*(https?://)?(.*?)(/)?\s*\z}, '\2')
  end
end
