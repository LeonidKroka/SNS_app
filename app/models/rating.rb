class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :estimator, :class_name => "User"

  before_action :other_user?

  validates :user, presence: true
  validates :user_id, presence: true
  validates :estimator, presence: true
  validates :estimator_id, presence: true
end
