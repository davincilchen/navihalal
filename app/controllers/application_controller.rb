class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  before_action :get_activities
  before_action :authenticate_user!

    
  # enter admin should has role = admin
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  private

  def get_activities
    if current_user
      #Polymorphic Associations
      #@activities = PublicActivity::Activity.includes(:trackable).order("created_at desc").where(owner_id: current_user.following_ids, owner_type: "User")
      @activities = PublicActivity::Activity.includes(:trackable).order("created_at desc").where(owner_id: current_user.following_ids, owner_type: "User").where("created_at > :user_check", :user_check => current_user.activity_checked_at)
    end
  end
end
