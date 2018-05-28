class Meal < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :restaurant
end
