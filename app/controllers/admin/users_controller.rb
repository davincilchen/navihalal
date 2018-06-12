# frozen_string_literal: true

module Admin
  # say something
  class UsersController < ApplicationController
    before_action :authenticate_admin
    def index
      @users = User.all
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path
        flash[:notice] = 'user was successfully updated'
      else
        @users = User.all
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

    def user_params
      params.require(:user).permit(:name, :email, :role, :avatar)
    end
  end
end
