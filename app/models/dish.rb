class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  validates_presence_of :name
  accepts_nested_attributes_for :restaurant, reject_if: :reject_restaurant
  validate :unique_dish, :unique_restaurant
  scope :most_popular, -> {order(popularity: :desc).limit(10)}

  def reject_restaurant(attributes)
    attributes[:name].blank? || attributes[:cuisine].blank? || attributes[:location].blank?
  end

  def unique_restaurant
    if self.name != "" && self.restaurant
      if self.restaurant_id == nil && self.restaurant.name != ""
        @existing_restaurants = Restaurant.where(name: self.restaurant.name)
        if !@existing_restaurants.empty?
          if @existing_restaurants.any? do |restaurant|
            restaurant.cuisine == self.restaurant.cuisine && restaurant.location == self.restaurant.location
          end
          errors.add(:restaurant_id, "already exists. Please add dish to the existing restaurant.")
          end
        end
      end
    end
  end

  def unique_dish
    @existing_dishes = Dish.where(name: self.name)
    if !@existing_dishes.empty?
      if @existing_dishes.any? do |dish|
         dish.restaurant == self.restaurant
         #exact dish exists, with selected restaurant
         end
         errors.add(:dish, "already exists at the restaurant you selected. Please add the existing dish to your Dish-List")
      # elsif
      #   #exact dish exists, newly entered restaurant already exists
      #   @existing_dishes.any? do |dish|
      #     dish.restaurant.name == self.restaurant.name && dish.restaurant.cuisine == self.restaurant.cuisine && dish.restaurant.location == self.restaurant.location
      #   end
      #   errors.add(:dish, "That dish and restaurant already exist. Please add the existing dish to your Dish-List")
      end
    end
  end

  def increase_popularity
    self.popularity += 1
    self.save(validate: false)
  end
end
