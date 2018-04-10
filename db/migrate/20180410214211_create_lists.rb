class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :status, default: "current"
      
      t.timestamps
    end
  end
end
