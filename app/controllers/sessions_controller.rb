class SessionsController < ApplicationController
  before_action :check_log_in, only: [:new, :create]

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash[:success] = "Welcome #{user.name}"
      redirect_to root_url
    else
      render :new
      flash[:info] = "Oops!! Email or Password Invalid"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
