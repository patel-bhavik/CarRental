class Admin::ReservationsController < Admin::AdminController
  include ApplicationHelper
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @cars = Car.where(:status => :available)
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.status = 'current'
    @reservation.user_id = @user.id
    @reservation.rental_charge = @reservation.calculate_rental_charge
    @car = @reservation.car
    @car.status = 'reserved'
    respond_to do |format|
      if @reservation.save and @car.save
        format.html { redirect_to admin_reservations_path, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        @cars = Car.where(:status => :available)
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(edit_reservation_params)
        format.html { redirect_to admin_reservations_path, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @car = @reservation.car
    car_status = :available
    if @reservation.destroy and @car.update(:status => car_status)
      send_notification(@car)
      respond_to do |format|
        format.html { redirect_to admin_reservations_path, notice: 'Reservation was successfully cancelled.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to admin_reservations_path, alert: 'Something went wrong!!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:from, :to, :car_id)
    end

    def edit_reservation_params
      params.require(:reservation).permit(:from, :to)
    end
end
