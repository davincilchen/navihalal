class RenameColumnInMeal < ActiveRecord::Migration[5.2]
  def change
    rename_column :meals, :type, :sort
  end
end
