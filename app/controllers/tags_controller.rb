class TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants.uniq
  end
end
