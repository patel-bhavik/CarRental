class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :reservation_history, :reserve_car]

  # GET admin/users
  # GET admin/users.json
  def index
    role = Role.find_by_name('Admin')
    @users = role.users
  end

  # GET admin/customers
  def customers
    role = Role.find_by_name('Customer')
    @users = role.users
  end

  def reservation_history
    @current_reservation = @user.reservations.where(:status => "Current").first
    @reservations = @user.reservations.where(:status => "Past")
  end

  # GET admin/users/1
  # GET admin/users/1.json
  def show
  end

  # GET admin/users/new
  def new
    @user = User.new
  end

  # GET admin/users/1/edit
  def edit
  end

  # POST admin/users
  # POST admin/users.json
  def create
    @user = User.new(user_params)
    unless @user.role
      @user.role = Role.find_by_name('Admin')
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/users/1
  # PATCH/PUT admin/users/1.json
  def update
    respond_to do |format|
      if @user.customer? and @user.update(user_params_update)
        format.html { redirect_to admin_customers_path, notice: 'The user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/users/1
  # DELETE admin/users/1.json
  def destroy
    if @user == current_user or @user.super_admin?
      return redirect_to admin_cars_url, alert: 'Cannot delete this user'
    end
    unless @user.reservations.empty?
      return redirect_to admin_cars_url, alert: 'Cannot delete this user!! There are reservations done by this user in the system'
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_cars_url, notice: 'The user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      redirect_to admin_users_path, alert: 'You are Unauthorized to access that page' if @user.super_admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :role_id)
    end
	
	def user_params_update
      params.require(:user).permit(:email, :first_name, :last_name)
    end
end
