class UsersController < ApplicationController
  layout 'landing'

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.list = List.new
      @user.save
      session[:user_id] = @user.id
      redirect_to welcome_path, alert: "Sign up successful"
    else
      render 'users/new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
