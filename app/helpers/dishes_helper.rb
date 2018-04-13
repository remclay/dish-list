module DishesHelper

  def included_in_list(dish)
    @list = List.find_by(id: session[:user_id])
    @list.dish_ids.include?(dish.id)
  end
end
