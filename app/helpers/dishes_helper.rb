module DishesHelper

  def user_has(dish)
    #Potentially instantiate user with list and remove conditional logic
    if current_user.list
      current_user.list.dishes.ids.include?(dish.id)
    end
  end
end
