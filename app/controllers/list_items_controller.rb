class ListItemsController < ApplicationController

  def create
    @list = current_user.list || current_user.create_list
    @list_item = @list.list_items.new(dish_id: params[:dish_id])
    if @list_item.save
      redirect_to list_path(@list), alert: "Dish added to list!"
    else
      redirect_to dishes_path, alert: "Unable to add dish to list"
    end
  end
end
