class AddColumnToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :business_hour, :string
  end
end
