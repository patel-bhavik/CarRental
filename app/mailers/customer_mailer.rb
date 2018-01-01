class CustomerMailer < ApplicationMailer
  def car_return_notification(user, car, reservation)
    @user = user
    @car = car
    @reservation = reservation
    mail to: user.email, subject: 'Reservation time has ended'
  end

  def car_available_notification(user, car)
    @user = user
    @car = car
    mail to: user.email, subject: 'Car you are are interested in is available!'
  end
end
