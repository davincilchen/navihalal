class AddColumnToMeal < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :type, :string
  end
end
