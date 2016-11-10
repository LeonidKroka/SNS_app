class Image < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :user_id, presence: true
end
