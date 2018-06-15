class CommentsController < ApplicationController
  before_action :set_restaurant
  
  def index
    if params[:id]
      @comment = Comment.find(params[:id])
    else
      @comment = Comment.new
    end
    @comments = @restaurant.comments
  end

  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_comments_path(@restaurant)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to restaurant_comments_path, notice: "Comment was successfully updated!"
    else
      @comments = @restaurant.comments
      render 'index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
  
end