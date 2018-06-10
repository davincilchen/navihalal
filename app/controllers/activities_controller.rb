class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.following_ids, owner_type: "User").limit(30)
 
    puts "current_user id"
    puts "#{current_user.id}"
    puts "----------"
    puts "#{@activities.size}"
    puts "----------"
    
    #puts "#{@current_user.following_ids}"

    puts "----------"
    #puts "#{@activities}"
    puts "----------"

    @activities.each do |activities|
    #  puts "#{activities.trackable_type}"
    end

    puts "#{ @activities.each.first}"
    user_check_activity
  end

  def check
    puts "----------check"
    user_check_activity
  end

  private

  def user_check_activity
    if current_user
        current_user.update(:activity_checked_at => Time.now)
    end
  end

end
