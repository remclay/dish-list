class ListItemsController < ApplicationController

  def create
    @list = current_user.list
    @list_item = @list.list_items.new(dish_id: params[:dish_id])
    if @list_item.save
      redirect_to list_path(@list), alert: "Dish added to list!"
    else
      redirect_to dishes_path, alert: "Unable to add dish to list"
    end
  end

  def destroy
    items = current_user.list.list_items
    items.find_by(dish_id: params[:dish_id]).destroy
    redirect_to list_path, alert: "Dish removed"
  end
end
