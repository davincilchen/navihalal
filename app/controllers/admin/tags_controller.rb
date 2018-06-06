class Admin::TagsController < ApplicationController
before_action :set_tag, only: %i[update destroy]

    def index
      @tags = Tag.page(params[:page]).per(10)
      if params[:id]
        set_tag
      else
        @tag = Tag.new
      end
    end

    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        flash[:notice] = "#{@tag.name} was successfully created"
        redirect_to admin_tags_path
      else
        flash[:notice] = "#{@tag.name} created fail"
        @tags = Tag.all
        render :index
      end
    end

    def update
      if @tag.update(tag_params)
        redirect_to admin_tags_path
        flash[:notice] = "#{@tag.name} was successfully updated"
      else
        @tags = Tag.all
        render :index
      end
    end

    def destroy
      @tag.destroy
      flash[:alert] = "#{@tag.name} was successfully deleted"
      redirect_to admin_tags_path
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end

end
