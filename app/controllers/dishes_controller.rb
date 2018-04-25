require 'pry'

class DishesController < ApplicationController
  before_action :authentication_required
  layout 'application'

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
      add_dish_to_list(@dish)
      redirect_to user_dishes_path(current_user), alert: "Dish successfully created and added to your list"
    else
      flash[:alert] = @dish.errors.full_messages.first
      redirect_to new_user_dish_path(current_user)
    end
  end

  def show
    @dish = Dish.find_by(id: params[:id])
  end

  def popular
    @dishes = Dish.most_popular
  end

  private

  def add_dish_to_list(dish)
    @list = current_user.list
    @list.add_item(dish.id)
  end

  def dish_params
    params.require(:dish).permit(:name, :restaurant_id, restaurant_attributes: [:name, :cuisine, :location])
  end
end
