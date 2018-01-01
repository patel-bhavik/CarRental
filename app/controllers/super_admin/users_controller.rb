class SuperAdmin::UsersController < SuperAdmin::SuperAdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET super_admin/users
  # GET super_admin/users.json
  def index
    role = Role.find_by_name('SuperAdmin')
    @users = role.users
  end

  # GET super_admin/users/1
  # GET super_admin/users/1.json
  def show
  end

  # GET super_admin/users/new
  def new
    @user = User.new
  end

  # GET super_admin/users/1/edit
  def edit
  end

  # POST super_admin/users
  # POST super_admin/users.json
  def create
    @user = User.new(user_params)
    unless @user.role
      @user.role = Role.find_by_name('SuperAdmin')
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to super_admin_users_path, notice: 'Super Admin was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT super_admin/users/1
  # PATCH/PUT super_admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to super_admin_users_path, notice: 'Super Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE super_admin/users/1
  # DELETE super_admin/users/1.json
  def destroy
    if @user == current_user or @user.super_admin?
      return redirect_to super_admin_users_path, alert: 'Super Admins cannot be deleted'
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to super_admin_users_path, notice: 'Super Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :role_id)
    end
end
