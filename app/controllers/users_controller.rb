class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user && @user.save
      log_in @user
      remember @user
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
      :password, :password_confirmation,
      :addr_one, :addr_two,
      :city, :country, :postcode)
  end
end
