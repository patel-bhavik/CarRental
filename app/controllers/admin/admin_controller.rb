class Admin::AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    redirect_to root_path unless current_user and ( current_user.admin? or current_user.super_admin? )
  end
end
