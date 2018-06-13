class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
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
  
end