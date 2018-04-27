class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :dish

  def mark_as_tasted
    self.tasted = true
    self.save
  end
end
