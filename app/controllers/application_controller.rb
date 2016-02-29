class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  def store_location
    return unless request.get?
    if (request.path != "/customers/sign_in" &&
        request.path != "/customers/sign_up" &&
        request.path != "/customers/sign_out" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  protected

  def set_customer
    @customer = current_customer
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname]
    devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname]
  end
end
