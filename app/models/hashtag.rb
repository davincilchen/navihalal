class Hashtag < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  belongs_to :tag
end
