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

  def tasted
    item = ListItem.find_by(list_id: params[:user_id], dish_id: params[:dish_id])
    item.status = true
    if item.save
      redirect_to user_dishes_path(current_user), alert: "Hope that dish was tasty!"
    else
      redirect_to user_dishes_path(current_user), alert: "Dish could not be updated"
    end
  end

  def destroy
    items = current_user.list.list_items
    items.find_by(dish_id: params[:dish_id]).destroy
    redirect_to list_path, alert: "Dish removed"
  end
end
