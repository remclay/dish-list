class AddStatusToListItems < ActiveRecord::Migration[5.1]
  def change
    add_column :list_items, :tasted, :boolean, :default => false
  end
end
