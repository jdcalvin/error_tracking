class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :today
  before_filter :organization
  require 'will_paginate/array'

  def today
    @today = Time.now.in_time_zone
  end
  
  protected
  
  def organization
    if user_signed_in?
      unless current_user.organization.nil?
        @organization = current_user.organization
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :admin])
  end
  
end
