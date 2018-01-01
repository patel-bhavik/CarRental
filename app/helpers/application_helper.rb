module ApplicationHelper

  def send_notification car
    @subscriptions = Subscription.where(:car_id => car.id)
    @subscriptions.each do |subscription|
      @user = User.find(subscription.user_id)
      CustomerMailer.car_available_notification(@user, car).deliver_now
      subscription.destroy
    end
  end

end
