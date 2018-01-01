class SuperAdmin::SuperAdminController < ApplicationController
  before_action :require_super_admin

  def require_super_admin
    redirect_to root_path unless current_user and current_user.super_admin?
  end
end
