class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :authenticate_user!
  
  
  
  
  protected
  
  #adds User.name to Devise's default strong parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_in) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
  
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
end
