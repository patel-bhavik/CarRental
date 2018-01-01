class SuggestedCar < ApplicationRecord
  enum status: { pending: 'Pending', accepted: 'Accepted', rejected: 'Rejected'}
  enum style: { coupe: 'Coupe', sedan: 'Sedan', suv: 'SUV' }

  validates :user_name, :manufacturer, :model, :style, :location, :status, presence: true
  validates_uniqueness_of :manufacturer, :scope => :model
end
