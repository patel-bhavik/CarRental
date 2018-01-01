class UsersController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
  before_action :not_logged_in, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :reservation_history]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def reservation_history
    @current_reservation = user_reservation
    @reservations = @user.reservations.where(:status => "Past")
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    unless @user.role
      @user.role = Role.find_by_name('Customer')
    end

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'Welcome to Car Rental Application.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :role_id)
    end
end
