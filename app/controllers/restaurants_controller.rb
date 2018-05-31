class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy, :collect, :uncollect]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    @page = "index"
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.title restaurant.name
      marker.infowindow restaurant.name
      marker.json({ :id => restaurant.id })
      marker.json({ :intro => restaurant.intro })
      marker.json({ :photo => request.protocol + request.host_with_port + restaurant.photo.url })
      marker.picture ({ #check assert pipeline
                       #url: ActionController::Base.helpers.asset_path("/images/icons/ig_site.png"),
                       #url: ActionController::Base.helpers.asset_path("ig_site.png"),
                       url: ActionController::Base.helpers.asset_path("ig_site.svg"),
                       width:  64,
                       height:  64,
                     })
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @meals = @restaurant.meals
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @restaurants = Restaurant.ransack(name_cont: params[:q]).result(distinct: true)
    @tags = Tag.ransack(name_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json {
        @restaurants = @restaurants.limit(5)
        @tags = @tags.limit(5)
      }
    end
  end

  def collect
    @restaurant.collects.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def uncollect
    collects = Collect.where(restaurant: @restaurant, user: current_user)
    collects.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :intro, :photo, :open_hour, :close_hour, :address, :tel, :viewed_count, :user_id, :latitude, :longitube)
  end
end
