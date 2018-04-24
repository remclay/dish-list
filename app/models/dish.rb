class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  validates_presence_of :name
  accepts_nested_attributes_for :restaurant, reject_if: :reject_restaurant

  def reject_restaurant(attributes)
    attributes[:name].blank? || attributes[:cuisine].blank? || attributes[:location].blank?
  end

  def increase_popularity
    self.popularity += 1
    self.save
  end

  def self.most_popular
    Dish.order(popularity: :desc).first(10)
  end
end
