class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_path, alert: "Welcome back"
      else
        flash[:notice] = "Invalid password"
        redirect_to login_path
      end
    else
      redirect_to login_path, alert: "Incorrect username"
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path, alert: "You have successfully logged out"
  end
end
