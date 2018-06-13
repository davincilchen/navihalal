class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin

  before_action :set_restaurant, only: %i[update destroy]

  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "#{@restaurant.name} was successfully created"
      redirect_to admin_restaurants_path
    else
      flash[:notice] = "#{@restaurant.name} created fail"
      @restaurants = Restaurant.all
      render :index
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path
      flash[:notice] = "#{@restaurant.name} was successfully updated"
    else
      @restaurants = Restaurant.all
      render :index
    end
  end

  def destroy
    @restaurant.destroy
    flash[:alert] = "#{@restaurant.name} was successfully deleted"
    redirect_to admin_restaurants_path
  end

  def import
    if Restaurant.import(params[:file])
      redirect_to restaurants_path, notice: "Restaurant Added Successfully."
    else
      flash[:notice] = "#{@restaurant.name} created fail"
      @restaurants = Restaurant.all
      redirect_back(fallback_location: root_path)
    end
  end
  
  # def update
  #   @restaurant = Restaurant.find(params[:id])
  #   if @restaurant.update(restaurant_params)
  #     redirect_to admin_restaurants_path
  #     flash[:notice] = 'Restaurant was successfully updated'
  #   else
  #     @restaurants = Restaurant.all
  #     render :index
  #   end
  # end

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

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end

