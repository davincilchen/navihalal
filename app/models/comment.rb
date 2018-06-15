class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :restaurant, counter_cache: true
  belongs_to :user
end
