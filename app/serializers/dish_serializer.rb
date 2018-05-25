class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :restaurant_id
  belongs_to :restaurant
end
