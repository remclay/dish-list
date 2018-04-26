module ListItemsHelper

  def tried_dish(dish)
    @list_item = ListItem.find_by(list_id: params[:user_id], dish_id: dish.id)
    if @list_item
      @list_item.tasted
    end
  end
end
