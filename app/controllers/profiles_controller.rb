class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_active_menu
  def dashboard
    @user = User.find(current_user.id)
    if @user.role? :admin
      redirect_to admin_users_path, :notice => "Aloah Admin!"
    else
      redirect_to edit_user_registration_path
    end
  end

  def set_active_menu
    params[:navbartop] = 'profile'
  end

end
