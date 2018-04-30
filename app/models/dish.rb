class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  validates_presence_of :name
  accepts_nested_attributes_for :restaurant, reject_if: :reject_restaurant
  validate :unique_dish, :unique_restaurant
  scope :most_popular, -> {order(popularity: :desc).limit(10)}

  def reject_restaurant(attributes)
    # Reject entry of new restaurant unless all attributes present
    attributes[:name].blank? || attributes[:cuisine].blank? || attributes[:location].blank?
  end

  def unique_dish
    # Find all dishes with the name entered
    @existing_dishes = Dish.where(name: self.name)
    if !@existing_dishes.empty?
      # Check if restaurant also matches
      if @existing_dishes.any? { |dish| dish.restaurant == self.restaurant }
         errors.add(:dish, "already exists at the restaurant you selected. Please add the existing dish to your Dish-List")
      end
    end
  end

  def unique_restaurant
    # If any restaurant details have been entered
    if self.restaurant
      # If an existing restaurant has not been selected, & a new restaurant name has been entered
      if self.restaurant_id == nil && self.restaurant.name != ""
        # Find all restaurants with that name
        @existing_restaurants = Restaurant.where(name: self.restaurant.name)
        if !@existing_restaurants.empty?
          # Check if location and cuisine also match
          if @existing_restaurants.any? do |rest|
            rest.cuisine == self.restaurant.cuisine && rest.location == self.restaurant.location
            end
            errors.add(:restaurant_id, "already exists. Please select the restaurant from the list.")
          end
        end
      end
    end
  end

  def increase_popularity
    self.popularity += 1
    self.save(validate: false)
  end
end
