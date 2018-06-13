class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants.uniq
  end
end
