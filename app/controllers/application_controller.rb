class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :user_reservation, :suggested_car_exist?, :user_subscription, :checked_out_by_current_user?
  before_action :require_user

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def user_reservation
    @reservation = Reservation.where(:user_id => current_user.id).where(:status => "Current").first
  end

  def suggested_car_exist?
    @reservation = SuggestedCar.where(:status => "Pending").first
  end

  def not_logged_in
    redirect_to root_path if logged_in?
  end

  def user_subscription car
    puts car.id
    @subscription = Subscription.where(:user_id => current_user.id).where(:car_id => car.id).first
  end

  def checked_out_by_current_user? car
    @reservation = Reservation.where(:car_id => car.id).where(:status => "Current").first
    @reservation.user_id == current_user.id
  end

  def require_user
    redirect_to login_path unless current_user
  end
end
