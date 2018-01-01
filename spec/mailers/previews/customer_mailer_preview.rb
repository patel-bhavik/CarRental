# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview
  def car_return_notification
    user = User.find(1)
    car = Car.find(1)
    reservation = Reservation.find(1)
    CustomerMailer.car_return_notification(user, car, reservation)
  end

  def car_available_notification
    user = User.find(1)
    car = Car.find(1)
    CustomerMailer.car_available_notification(user, car)
  end
end
