class Subscription < ApplicationRecord
  validates :car_id, :user_id, presence: true
  validates_uniqueness_of :car_id, :scope => :user_id
end
