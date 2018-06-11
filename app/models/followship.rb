class Followship < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: Proc.new{ |controller, model| controller &&controller.current_user }
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User"

end
