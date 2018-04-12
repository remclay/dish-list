class List < ApplicationRecord
  belongs_to :user
  has_many :list_items
  has_many :dishes, through: :list_items

  def add_item(dish_id)
    self.list_items.create(dish_id: dish_id)
  end
end
