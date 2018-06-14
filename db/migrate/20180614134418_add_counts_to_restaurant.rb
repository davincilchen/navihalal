class AddCountsToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :comments_count, :integer, default: 0
  end
end
