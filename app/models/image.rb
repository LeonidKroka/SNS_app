class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :user_id, presence: true
end
