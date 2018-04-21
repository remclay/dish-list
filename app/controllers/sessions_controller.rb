class SessionsController < ApplicationController

  def new
  end

  def create
    # Log in with OmniAuth path
    if auth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = user.id
      if user.list == nil
        user.build_list
        user.save
      end
      redirect_to welcome_path
    else # Regular log in path
      @user = User.find_by(email: params[:email])
      if @user
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to welcome_path, alert: "Welcome back"
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
  end

  def destroy
    session.delete :user_id
    redirect_to root_path, alert: "You have successfully logged out"
  end
end
