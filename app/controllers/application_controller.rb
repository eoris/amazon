class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def set_customer
      @customer = current_customer
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname]
      devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname]
    end
end
