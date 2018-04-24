class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  validates_presence_of :name
  accepts_nested_attributes_for :restaurant, reject_if: :reject_restaurant
  validate :unique_dish, :unique_restaurant

  def reject_restaurant(attributes)
    attributes[:name].blank? || attributes[:cuisine].blank? || attributes[:location].blank?
  end

  def unique_restaurant
    if self.restaurant_id == nil && self.restaurant.name != ""
      @existing_restaurants = Restaurant.where(name: self.restaurant.name)
      if !@existing_restaurants.empty?
        if @existing_restaurants.any? do |restaurant|
          restaurant.cuisine == self.restaurant.cuisine && restaurant.location == self.restaurant.location
        end
        errors.add(:restaurant_id, "Restaurant already exists")
        # && @existing_restaurants.cuisine == self.restaurant.cuisine && @existing_restaurant.location == self.restaurant.location
        # errors.add(:restaurant_id, "Restaurant already exists")
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
         errors.add(:restaurant_id, "That dish already exists at the restaurant you selected. Please add the existing dish to your Dish-List")
         #redirect_to restaurant // existing_dish
      elsif
        #exact dish exists, newly created restaurant already exists
        @existing_dishes.any? do |dish|
          dish.restaurant.name == self.restaurant.name && dish.restaurant.cuisine == self.restaurant.cuisine && dish.restaurant.location == self.restaurant.location
        end
        errors.add(:restaurant_id, "That dish and restaurant already exist. Please add the existing dish to your Dish-List")
      end
    end
  end

  def increase_popularity
    self.popularity += 1
    self.save
  end

  def self.most_popular
    Dish.order(popularity: :desc).first(10)
  end
end
