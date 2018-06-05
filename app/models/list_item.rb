class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :dish

  def mark_as_tasted
    self.tasted = true
    self.save
  end

  def dish_name
    self.dish.name
  end

  def restaurant_name
    self.dish.restaurant.name
  end

  def restaurant_location
    self.dish.restaurant.location
  end
end
