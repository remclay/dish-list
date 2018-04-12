class AddPopularityToDishes < ActiveRecord::Migration[5.1]
  def change
    add_column :dishes, :popularity, :integer
  end
end
