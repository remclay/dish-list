class AddStatusToListItems < ActiveRecord::Migration[5.1]
  def change
    add_column :list_items, :status, :boolean, :default => false
  end
end
