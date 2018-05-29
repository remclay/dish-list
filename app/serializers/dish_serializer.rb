class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :restaurant_id
  has_one :restaurant, serializer: RestaurantSerializer
end
