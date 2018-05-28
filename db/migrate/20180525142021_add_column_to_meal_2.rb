class AddColumnToMeal2 < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :restaurant_id, :integer
  end
end
