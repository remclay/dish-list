class ListItemsController < ApplicationController

  def create
    @list = current_user.list
    @list_item = @list.list_items.new(dish_id: params[:dish_id])
    if @list_item.save
      increase_dish_popularity
      redirect_to user_dishes_path(current_user), alert: "Dish successfully added to your list"
    else
      redirect_to user_dishes_path(current_user), alert: "Unable to add dish to list"
    end
  end

  def increase_dish_popularity
    @list_item.dish.increase_popularity
  end

  def destroy
    items = current_user.list.list_items
    items.find_by(dish_id: params[:dish_id]).destroy
    redirect_to list_path, alert: "Dish removed"
  end
end
