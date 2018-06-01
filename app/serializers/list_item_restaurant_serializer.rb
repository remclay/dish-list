class ListItemRestaurantSerializer < ActiveModel::Serializer
  attributes :name, :location
  has_one :dish
end
