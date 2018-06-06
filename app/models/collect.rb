class Collect < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller &&controller.current_user }
  #tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :restaurant
  belongs_to :user
end
