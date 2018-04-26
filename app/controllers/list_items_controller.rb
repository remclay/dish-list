class ListItemsController < ApplicationController
  before_action :authentication_required
  before_action :set_list, except: [:increase_dish_popularity]
  before_action :set_list_item, only: [:tasted, :destroy]
  layout 'application'

  # Add existing dish to current user's list
  def create
    list_item = @list.list_items.build(dish_id: params[:dish_id])
    if list_item.save
      increase_dish_popularity(list_item.dish)
      redirect_to user_dishes_path(current_user), alert: "Dish successfully added to your list"
    else
      redirect_to user_dishes_path(current_user), alert: "Unable to add dish to list"
    end
  end

  def increase_dish_popularity(dish)
    dish.increase_popularity
  end

  # Update dish tasted attribute to true
  def tasted
    if @list_item
      @list_item.tasted = true
      if @list_item.save
        redirect_to user_dishes_path(current_user), alert: "Hope that dish was tasty!"
      else
        redirect_to user_dishes_path(current_user), alert: "Dish could not be updated"
      end
    else
      redirect_to user_dishes_path(current_user), alert: "Dish could not be updated"
    end
  end

  def destroy
    @list_item.destroy
    redirect_to user_dishes_path(current_user), alert: "Dish removed"
  end

  private
  def set_list
    @list = current_user.list
  end

  def set_list_item
    @list_item = ListItem.find_by(list_id: @list.id, dish_id: params[:dish_id])
  end
end
