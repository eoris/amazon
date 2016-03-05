class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, alert: exception.message
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

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
    stored_location_for(resource) ||
      if resource.is_a?(Admin)
        admin_dashboard_path
      else
        session[:previous_url] || root_path
      end
  end

  protected

  def set_customer
    @customer = current_customer
  end

  alias :current_user :current_customer

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname]
    devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname]
  end
end
