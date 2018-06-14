class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def collection
    @user = User.find(params[:id])
    @restaurants = current_user.collected_restaurants
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def position
    puts "------position------"
    puts"#{params[:position][:latitude]}"
    puts"#{params[:position][:longitude]}"

    if current_user
      latitude = params[:position][:latitude]
      longitude = params[:position][:longitude]

      puts"#{latitude}"
      puts"#{longitude}"
      if latitude>=0.0 && latitude <= 180.0
        if longitude>=0.0 && longitude <= 180.0
           current_user.update(:latitude => latitude, :longitude=>longitude)
           puts "------position save------"
        end
      end
    end
  end
  
end
