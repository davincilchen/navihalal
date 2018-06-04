class Hashtag < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :restaurant
  belongs_to :user
  belongs_to :tag

  validates_uniqueness_of :tag_id, scope: [:user_id, :restaurant_id]

  def self.user_tags(user)
    Hashtag.where(user: user)
  end

  #@hashtag = restaurant.hashtags.user_tags(current_user)
  #@hashtag.each do |h|
  #  puts "#{h.tag.name}"
  #end
end
