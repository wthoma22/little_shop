class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if current_user.admin?
        redirect_to admin_dashboard_path(@user)
      else
        redirect_to '/dashboard'
      end
    else
      redirect_to '/login', alert: "Incorrect username or password"
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
