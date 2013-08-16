class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_filter :set_active_menu

  protect_from_forgery
  def has_role?(current_user, role)
    current_user.roles.find_by_name(role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_locale
    I18n.locale = I18n.default_locale
    debugger
  end

  def set_active_menu
    params[:navbartop] = params[:controller]
    logger.info params[:controller]
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end

end
