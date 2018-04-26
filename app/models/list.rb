class List < ApplicationRecord
  belongs_to :user
  has_many :list_items
  has_many :dishes, through: :list_items

  # Create list_item in current_user list, Dish model increases dish popularity
  def add_item(dish_id)
    self.list_items.create(dish_id: dish_id)
    @dish = Dish.find_by(id: dish_id)
    @dish.increase_popularity
  end
end
