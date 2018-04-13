module ListItemsHelper

  def tried_dish(dish)
    @list_item = ListItem.find_by(list_id: params[:user_id], dish_id: dish.id)
    @list_item.status
  end
end
