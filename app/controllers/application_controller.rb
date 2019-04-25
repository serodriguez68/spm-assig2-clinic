class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :phone])
  end

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    if resource.patient?
      my_appointments_path
    elsif resource.admin?
      all_appointments_path
    end
  end
end
