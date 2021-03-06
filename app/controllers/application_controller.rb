class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  before_action :get_activities
  before_action :authenticate_user!
  before_action :is_name?

    
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
      gon.activities_count = @activities.count
    end
  end

  def is_name?
    if user_signed_in? && current_user.name.nil?
      current_user.update!(name: current_user.email.split('@').first)
    end
  end

end
