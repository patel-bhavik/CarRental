class Admin::CarsController < Admin::AdminController
  include ApplicationHelper
  before_action :set_car, only: [:show, :edit, :update, :destroy, :reservation_history, :edit_status, :update_status]
  before_action :set_suggested_car, only: [:new_suggested_car, :create_suggested_car]
  # GET admin/cars
  # GET admin/cars.json
  def index
    @cars = Car.where.not(:status => :inactive).paginate(:page => params[:page], :per_page => 8)
  end

  # GET admin/cars/1
  # GET admin/cars/1.json
  def show
  end

  # GET admin/cars/1/reservation_history
  # GET admin/cars/1/reservation_history.json
  def reservation_history
    @reservations = @car.reservations
  end

  # GET admin/cars/new
  def new
    @car = Car.new
    puts "In desired method."
  end

  # GET admin/cars/1/edit
  def edit
  end

  # POST astatusdmin/cars
  # POST admin/cars.json
  def create
    @car = Car.new(car_params)
    @car.status = "available"
    respond_to do |format|
      if @car.save
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_suggested_car
    @car = Car.new
    @car.manufacturer = @suggested_car.manufacturer
    @car.model = @suggested_car.model
    @car.style = @suggested_car.style
    @car.location = @suggested_car.location
  end

  def create_suggested_car
    @car = Car.new(car_params)
    @car.status = "available"
    @suggested_car_status = "accepted"
    respond_to do |format|
      if @car.save and @suggested_car.update(:status => @suggested_car_status)
        format.html { redirect_to admin_cars_path, notice: 'Suggested Car was successfully accepted and added into the system.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT admin/cars/1
  # PATCH/PUT admin/cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET admin/cars/1/edit_status
  def edit_status
  end

  # PATCH/PUT admin/cars/1/update_status
  def update_status
    @reservation = @car.reservations.where(:status => 'Current').first
    respond_to do |format|
      if @car.reserved?
        car_status = :checked_out
        reservation_status = 'current'
        message = 'Car was successfully checked out.'
      else
        car_status = :available
        reservation_status = 'past'
        message = 'Car was successfully returned.'
      end
      if @car.update(:status => car_status) and @reservation.update(:status => reservation_status)
        if reservation_status == 'past'
          send_notification(@car)
        end
        format.html { redirect_to admin_customers_path, notice: message }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit_status, alert: 'Something went wrong!!' }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/cars/1
  # DELETE admin/cars/1.json
  def destroy
    return redirect_to admin_cars_path, notice: 'Car is still in use, It cannot be deleted now' unless @car.available?
    if @car.reservations
      @car.update(status: :inactive)
      respond_to do |format|
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully marked as inactive.' }
        format.json { head :no_content }
      end
    else
      @car.destroy
      respond_to do |format|
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_suggested_car
      @suggested_car = SuggestedCar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:licence_no, :manufacturer, :model, :style, :hourly_rate, :location, :status)
    end
end
