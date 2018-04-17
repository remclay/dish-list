class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, alert: "Welcome back"
      else
        #refactor this away
        flash[:notice] = "Invalid password"
        render 'sessions/new'
      end
    else
      flash[:notice] = "Incorrect email"
      render 'sessions/new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path, alert: "You have successfully logged out"
  end
end
