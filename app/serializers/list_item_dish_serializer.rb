class ListItemDishSerializer < ActiveModel::Serializer
  attributes :name, :restaurant_id
  belongs_to :restaurant, serializer: ListItemRestaurantSerializer
end
