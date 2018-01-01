class SuggestedCarsController < ApplicationController
  before_action :set_suggested_car, only: [:show, :edit, :update, :destroy]

  # GET /suggested_cars
  # GET /suggested_cars.json
  def index
    @suggested_cars = SuggestedCar.where(:status => "Pending")
  end

  # GET /suggested_cars/1
  # GET /suggested_cars/1.json
  def show
  end

  # GET /suggested_cars/new
  def new
    @suggested_car = SuggestedCar.new
  end

  # GET /suggested_cars/1/edit
  def edit
  end

  # POST /suggested_cars
  # POST /suggested_cars.json
  def create
    @suggested_car = SuggestedCar.new(suggested_car_params)
    @suggested_car.status = "pending"
    @suggested_car.user_name = current_user.first_name+" "+current_user.last_name
    respond_to do |format|
      if @suggested_car.save
        format.html { redirect_to root_path, notice: 'Car Suggestion Submitted Successfully.' }
        format.json { render :show, status: :created, location: @suggested_car }
      else
        format.html { render :new }
        format.json { render json: @suggested_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggested_cars/1
  # PATCH/PUT /suggested_cars/1.json
  def update
    @suggested_car.status = "rejected"
    respond_to do |format|
      if @suggested_car.update(suggested_car_params)
        format.html { redirect_to admin_cars_path, notice: 'Car Suggestion Rejected Successfully.' }
        format.json { render :show, status: :ok, location: @suggested_car }
      else
        format.html { render :edit }
        format.json { render json: @suggested_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggested_cars/1
  # DELETE /suggested_cars/1.json
  def destroy
    @suggested_car.destroy
    respond_to do |format|
      format.html { redirect_to suggested_cars_url, notice: 'Suggested car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggested_car
      @suggested_car = SuggestedCar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggested_car_params
      params.require(:suggested_car).permit(:user_name, :manufacturer, :model, :style, :location, :status)
    end
end
