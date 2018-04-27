class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authentication_required
    if !logged_in?
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
end
