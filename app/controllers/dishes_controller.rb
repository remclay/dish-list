require 'pry'

class DishesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    binding.pry
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :restaurant_id)
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access that page"
      redirect_to new_user_registration_path
    end
end
