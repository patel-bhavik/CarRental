class ReservationInvalidationJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(car, reservation)
    if reservation.car == car and car.reservations.where(:status => :current).first == reservation and !car.checked_out?
      car.update(:status => :available)
      reservation.destroy
      send_notification(car)
    end
  end
end
