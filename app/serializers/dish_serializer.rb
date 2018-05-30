class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :restaurant_id, :popularity
  has_one :restaurant, serializer: RestaurantSerializer
end
