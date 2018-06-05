class ListItemSerializer < ActiveModel::Serializer
  attributes :id, :list_id, :dish_id, :dish_name, :restaurant_name, :restaurant_location
end
