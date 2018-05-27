class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :restaurant_id
      t.integer :meal_id
      t.string :type

      t.timestamps
    end
  end
end
