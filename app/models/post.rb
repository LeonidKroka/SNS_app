class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  before_destroy :delete_post_id_in_images

  validates :user, presence: true
  validates :user_id, presence: true
  validates :text, presence: true, if: "images.nil?"
  validates :images, presence: true, if: "text.nil?"

  def delete_post_id_in_images
    self.images.each { |image| image.post_id = nil }
  end
end
