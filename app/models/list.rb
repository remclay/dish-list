class List < ApplicationRecord
  belongs_to :user
  has_many :list_items
  has_many :dishes, through: :list_items
  validates_presence_of :title
end
