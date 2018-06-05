class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def downgrade
    @user = current_user
    current_user.update_attribute(:role, 'standard')
    current_user.wikis.update_all(private: false)
    flash[:notice] = "You are no longer a premium user! Please continue your subscription to have access to Premium content"
    redirect_to user_path(current_user)
  end
end
