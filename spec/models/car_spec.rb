require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'car is valid if every field is valid' do
    car = build(:car)
    expect(car.valid?).to be true
  end

  it 'licence number should be of length 7' do
    car = build(:car, :invalid_licence)
    expect(car.valid?).to be false
  end

  it 'hourly rate should be numerical' do
    car = build(:car, :invalid_hourly_rate)
    expect(car.valid?).to be false
  end

  it 'hourly rate should be positive or zero' do
    car = build(:car, :negative_hourly_rate)
    expect(car.valid?).to be false
  end

  it 'licence number should be unique' do
    car = build(:car)
    car.save
    car_with_same_licence = build(:car)
    expect(car_with_same_licence.valid?).to be false
  end
end
