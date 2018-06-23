class Comment < ApplicationRecord
  acts_as_votable
  validates :content, presence: true
  belongs_to :restaurant, counter_cache: true
  belongs_to :user
end
