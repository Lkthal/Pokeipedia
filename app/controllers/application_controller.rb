class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  before_action :authenticate_user!

end
