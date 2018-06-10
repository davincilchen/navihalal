class AddChecktimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activity_checked_at, :datetime, :default => DateTime.now
  end
end
