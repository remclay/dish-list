class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :list_items
  has_many :lists, through: :list_items
  accepts_nested_attributes_for :restaurant
end
