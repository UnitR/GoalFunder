class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
      @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/home/manage", notice: 'User deleted.'
  end
end
