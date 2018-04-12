module DishesHelper

  def user_has(dish)
    current_user.list.dishes.ids.include?(dish.id)
  end
end
