class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    @restaurants = Restaurant.all
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path
      flash[:notice] = 'Restaurant was successfully updated'
    else
      @restaurants = Restaurant.all
      render :index
    end
  end

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = 'Not allow!'
      redirect_to root_path
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :intro, :photo, :open_hour, :close_hour, :address, :tel, :viewed_count, :user_id, :latitude, :longitube, :rest_day, :business_hour)
  end
end

