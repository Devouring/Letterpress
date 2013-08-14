class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_active_menu

  protect_from_forgery
  def has_role?(current_user, role)
    current_user.roles.find_by_name(role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_active_menu
    params[:navbartop] = path[:controller]
  end

end
