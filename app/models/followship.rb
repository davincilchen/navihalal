class Followship < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller &&controller.current_user }
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User"

end
