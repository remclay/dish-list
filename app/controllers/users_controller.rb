class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.list = List.new
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path, alert: "Sign up successful" #your_list?
    else
      render 'users/new' #redirect_to new_user_path #'signup'
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    if @user && @user.id == params[:id].to_i
      # if @user.update(user_params)
      #   redirect_to user_path(@user), alert: "Your details have been successfully updated"
      if params[:user][:email] != ""
        @user.email = params[:user][:email]
      end
      if params[:user][:password] != "" && (params[:user][:password] == params[:user][:password_confirmation])
        @user.password = params[:user][:password]
      end
    else
      redirect_to edit_user_path(@user)
    end
    else
      redirect_to user_path(@user)
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
