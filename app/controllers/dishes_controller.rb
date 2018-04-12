require 'pry'

class DishesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    if params[:user_id]
      @dishes = current_user.list.dishes
    else
      @dishes = Dish.all
    end
  end

  def new
    @dish = Dish.new
    @restaurants = Restaurant.all
    @restaurant = Restaurant.new
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      add_to_list
      redirect_to user_dishes_path(current_user), alert: "Dish successfully created and added to your list"
    else
      flash[:alert] = @dish.errors.full_messages.first
      redirect_to new_user_dish_path(current_user)
    end
  end

  def show
    @dish = Dish.find_by(id: params[:id])
  end

  def add_to_list
    current_user.list.list_items.build
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :restaurant_id, restaurant_attributes: [:name, :cuisine, :location])
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access that page"
      redirect_to new_user_registration_path
    end
  end
end
