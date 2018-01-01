class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :user
  enum status: { current: 'Current', past: 'Past' }
  validate :booking_time
  validate :booking_within_seven_days, :on => :create
  validate :valid_time, :on => :create

  def booking_time
    return if (to - from) / 1.hour >= 1 and (to - from) / 1.hour <= 10
    if to <= from
      errors.add(:base, 'To date should be larger than from date')
    elsif (to - from) / 1.hour < 1
      errors.add(:base, 'Booking should be made for more than 1 hour')
    else
      errors.add(:base, 'Booking should be made for less than 10 hour')
    end
  end

  def booking_within_seven_days
    return if ((from - DateTime.now) / 1.day) < 7
    errors.add(:base, 'Reservation within 7 days are only possible')
  end

  def valid_time
    return if from >= DateTime.now and to >= DateTime.now
    errors.add(:base, 'Time should be more than current time')
  end

  def calculate_rental_charge
    (((to - from) / 1.hour) * car.hourly_rate).round
  end

  def is_within_date_range? a_date
    from <= a_date and a_date <= to
  end

  def valid_time_to_check_out?
    time_diff = from - DateTime.now
    time_diff <= 10.minutes
  end
end
