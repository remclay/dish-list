require 'pry'

class DishesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @dish = Dish.new
    @restaurants = Restaurant.all
    @restaurant = Restaurant.new
    @lists = current_user.lists
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      if params[:dish][:list_ids]
        assign_to_list
      end
      redirect_to dish_path(@dish), alert: "Dish successfully created"
    else
      flash[:alert] = @dish.errors.full_messages.first
      redirect_to new_dish_path
    end
  end

  def show
    @dish = Dish.find_by(id: params[:id])
  end

  def assign_to_list
    @list = current_user.lists.find_by(id: params[:dish][:list_ids])
    list_item = @list.list_items.create(dish_id: @dish.id)
    # Move and abstract away. Add conditional logic if !list_item.save
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :restaurant_id, restaurant_attributes: [:name, :cuisine, :location])
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access that page"
      redirect_to new_user_registration_path
    end
  end
end
