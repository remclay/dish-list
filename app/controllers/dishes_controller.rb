require 'pry'

class DishesController < ApplicationController
  before_action :authentication_required
  layout 'default'

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
    if params[:dish][:restaurant_id] != "" && params[:dish][:restaurant_attributes][:name] != ""
      redirect_to new_user_dish_path(current_user), alert: "Please either select an existing restaurnt or add a new one"
    else
      @dish = Dish.new(dish_params)
      if @dish.save
        add_dish_to_list
        redirect_to user_dishes_path(current_user), alert: "Dish successfully created and added to your list"
      else
        flash[:alert] = @dish.errors.full_messages.first
        redirect_to new_user_dish_path(current_user)
      end
    end
  end

  def show
    @dish = Dish.find_by(id: params[:id])
  end

  def add_dish_to_list
    @list = current_user.list
    @list.add_item(@dish.id)
    #No validation here yet
  end

  def popular
    @dishes = Dish.most_popular
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :restaurant_id, restaurant_attributes: [:name, :cuisine, :location])
  end
end
