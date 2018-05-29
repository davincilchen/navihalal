class Tag < ApplicationRecord
  has_many :hashtags
  has_many :users, through: :hashtags
  has_many :restaurants, through: :hashtags

  def uniq_users
    return self.users.uniq
  end

  def uniq_restaurants
    return self.restaurants.uniq
  end
end
