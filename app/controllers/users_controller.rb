class UsersController < ApplicationController

  def show
  end

  def collection
    @restaurants = current_user.collected_restaurants
  end
  
end
