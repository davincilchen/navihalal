class ActivitiesController < ApplicationController
    #protect_from_forgery :except => :check

  def index
    @activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.following_ids, owner_type: "User").limit(30)
    user_check_activity
  end

  def check
    user_check_activity
  end

  private


  def user_check_activity
    if current_user
        current_user.update(:activity_checked_at => Time.now)
    end
  end

end
