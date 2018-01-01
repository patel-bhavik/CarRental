class ReservationEndJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(car, reservation)
    if reservation.car == car and car.reservations.where(:status => :current).first == reservation and car.checked_out?
      car.update(:status => :available)
      reservation.update(:status => :past)
      send_notification(car)
      CustomerMailer.car_return_notification(reservation.user, car, reservation).deliver_now
    end
  end
end
