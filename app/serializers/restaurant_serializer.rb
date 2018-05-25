class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuisine, :location
  has_many :dishes
end
