class Tag < ApplicationRecord
  has_many :hashtags, dependent: :destroy
  has_many :users, through: :hashtags
  has_many :restaurants, through: :hashtags

  def sorted?
    restaurants.count != 0
  end
end
