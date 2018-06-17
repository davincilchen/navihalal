class CommentsController < ApplicationController
  before_action :set_restaurant
  before_action :set_comment, except: [:index, :create]
  
  def index
    if params[:id]
      set_comment
    else
      @comment = Comment.new
    end
    @comments = @restaurant.comments.order(updated_at: :desc)
  end

  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to restaurant_comments_path(@restaurant)
  end

  def update
    if @comment.update(comment_params)
      redirect_to restaurant_comments_path, notice: "Comment was successfully updated!"
    else
      @comments = @restaurant.comments
      render 'index'
    end
  end

  def destroy
    @comment.destroy && set_restaurant
  end

  def upvote
    @comment.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @comment.downvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
end