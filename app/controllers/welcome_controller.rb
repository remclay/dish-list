class WelcomeController < ApplicationController

  def index
    if logged_in?
      redirect_to welcome_path
    else
      render layout: "landing"
    end
  end

  def home
    render layout: "welcome"
  end
end
