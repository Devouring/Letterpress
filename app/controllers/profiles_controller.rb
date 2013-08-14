class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def dashboard
    @user = User.find(current_user.id)
    if @user.role? :admin
      redirect_to admin_users_path
    else
      redirect_to edit_user_registration_path
    end
  end
end
