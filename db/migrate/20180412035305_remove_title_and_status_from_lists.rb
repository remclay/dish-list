class RemoveTitleAndStatusFromLists < ActiveRecord::Migration[5.1]
  def change
    remove_column :lists, :title
    remove_column :lists, :status
  end
end
