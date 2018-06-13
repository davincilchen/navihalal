class AddPosToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :longitude, :float, default: 0.0 
    add_column :users, :latitude, :float, default: 0.0 
  end
end
