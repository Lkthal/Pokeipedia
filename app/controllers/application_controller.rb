class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
     wikis_path
   end

  private

  def user_not_authorized
    flash[:alert] = "Sorry, you are not allowed to do that."
    redirect_to(request.referrer || root_path)
  end
end
