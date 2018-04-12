class SessionsController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:notice] = "Invalid password"
        redirect_to new_sesison_path
      end
    else
      redirect_to new_session_path
    end
  end
end
