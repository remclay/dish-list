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

  def update
    @user = current_user
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
