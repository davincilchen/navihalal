class CommentsController < ApplicationController
  
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.new
    @comments = @restaurant.comments
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_comments_path(@restaurant)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
