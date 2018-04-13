class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  accepts_nested_attributes_for :restaurant, reject_if: proc { |attributes| attributes[:name].blank? }
  validates_presence_of :name

  def increase_popularity
    self.popularity += 1
    self.save
  end

  def self.most_popular
    Dish.order(popularity: :desc).first(10)
  end
end
