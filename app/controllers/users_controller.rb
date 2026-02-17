class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all.map { |u| user_json(u) }
    render json: users
  end

  def show
    render json: user_json(@user)
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user_json(user)
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: user_json(@user)
    else
      render json: @user.errors
    end
  end

  def destroy
    @user.destroy
    render json: { message: "Deleted successfully" }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :phone, :address, :profile_picture)
  end

  def user_json(user)
    user.as_json.merge(
      profile_picture_url: user.profile_picture.attached? ?
        url_for(user.profile_picture) : nil
    )
  end
end
