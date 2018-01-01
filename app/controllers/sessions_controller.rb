class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :require_user, only: [:new, :create]
  before_action :not_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      unless user.customer?
        return redirect_to admin_cars_path
      end
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
