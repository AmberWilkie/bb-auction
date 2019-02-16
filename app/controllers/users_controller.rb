class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @is_current_user = @user == current_user
    @products = @user.products
  end
end
