class UsersController < ApplicationController
  before_action :get_users, except: [ :new, :create]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def get_users
    @user = User.find_by id: params[:id]
  end
end
