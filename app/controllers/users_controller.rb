class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def collection
    @user = User.find(params[:id])
    @restaurants = current_user.collected_restaurants
  end
  
end
