class ListItemSerializer < ActiveModel::Serializer
  attributes :id, :list_id, :dish_id
  belongs_to :dish, serializer: ListItemDishSerializer
end
