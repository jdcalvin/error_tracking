class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	include Pundit
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :except => [:home, :help, :contact]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :today

  def today
    @today = Date.today.in_time_zone
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end


  
end
