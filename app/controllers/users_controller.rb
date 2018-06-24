class UsersController < ApplicationController
  before_action :set_user, except: [:position]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile successfully updated!"
    else
      render 'edit', alert: "Profile was failed to update."
    end
  end

  def collection
    @restaurants = current_user.collected_restaurants
  end

  def followings
    @followings = @user.followings
  end

  def position
    if current_user
      latitude = params[:position][:latitude]
      longitude = params[:position][:longitude]
      if latitude>=0.0 && latitude <= 180.0
        if longitude>=0.0 && longitude <= 180.0
           current_user.update(:latitude => latitude, :longitude=>longitude)
        end
      end
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:photo, :name, :birthday, :intro, :residence, :country)
  end
  
end
