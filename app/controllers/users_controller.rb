class UsersController < ApplicationController

  def show
    @activities = PublicActivity::Activity.all.limit(15)

    puts "----------"
    puts "#{@activities.size}"

    puts "----------"
    puts "#{@activities}"
    puts "----------"

    @activities.each do |activities|
      puts "#{activities.trackable_type}"
    end

  end

  def collection
    @restaurants = current_user.collected_restaurants
  end
  
end
