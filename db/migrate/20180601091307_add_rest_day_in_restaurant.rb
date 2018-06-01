class AddRestDayInRestaurant < ActiveRecord::Migration[5.2]
  def change
    change_column :restaurants, :open_hour, :time
    change_column :restaurants, :close_hour, :time
    add_column :restaurants, :rest_day, :string
  end
end
