class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
