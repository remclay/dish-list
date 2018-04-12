module DishesHelper

  def included_in_list(dish)
    @list = User.find_by(id: session[:user_id]).list
    @list.dishes.include?(dish)
  end
end
