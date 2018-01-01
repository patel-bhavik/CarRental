class ReservationsController < ApplicationController
  include ApplicationHelper
  before_action :set_car,:set_user, only: [:new, :create]

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @car.status = "reserved"
    @reservation.car_id = @car.id
    @reservation.user_id = @user.id
    @reservation.status = "current"
    @reservation.rental_charge = @reservation.calculate_rental_charge

    respond_to do |format|
      if @reservation.save && @car.save
        ReservationInvalidationJob.set(wait_until: @reservation.from + 30.minutes).perform_later(@car, @reservation)
        ReservationEndJob.set(wait_until: @reservation.to).perform_later(@car, @reservation)
        format.html { redirect_to root_path, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @current_reservation = user_reservation
    @current_car = Car.find(@reservation.car_id)
    @car_status = "available"
    if @current_reservation.destroy and @current_car.update(:status => @car_status)
      send_notification(@current_car)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Reservation was successfully cancelled.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to root_path, alert: 'Something went wrong!!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:car_id])
    end

    def set_user
      unless current_user.reservations.where(:status => 'Current').empty?
        return redirect_to root_path, alert: 'You already have a reservation!!'
      end
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:id , :from, :to)
    end
end
