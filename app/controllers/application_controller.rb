class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin
    unless current_user && current_user.admin
      flash[:alert] = "You must be an admin to do that!"
      redirect_to root_path
    end
  end

  def require_login
    unless current_user
      flash[:alert] = "You need to log in to do that!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :avatar
  end
end
