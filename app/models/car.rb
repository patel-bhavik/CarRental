class Car < ApplicationRecord
  enum status: { available: 'Available', reserved: 'Reserved', checked_out: 'Checked out', inactive: 'Inactive'}
  enum style: { coupe: 'Coupe', sedan: 'Sedan', suv: 'SUV' }
  has_many :reservations
  has_many :users, through: :reservations

  validates :licence_no, :manufacturer, :model, :style, :hourly_rate, :location, :status, presence: true
  validates :licence_no, length: { is: 7 }
  validates :licence_no, uniqueness: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 0 }
end
