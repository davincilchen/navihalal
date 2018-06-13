class UsersController < ApplicationController
  before_action :set_user

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

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:photo, :name, :birthday, :intro, :residence, :country)
  end
  
end