class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Successfully updated!"
      redirect_to profile_path(@user.username)
    else
      flash.now[:alert] = "Your post couldn't be updated"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:bio, :image)
  end

  def set_user
    @user = User.find_by_username(params[:username])
  end

  def owned_profile
    @user = User.find_by_username(params[:username])
    unless current_user == @user
      flash[:alert] = "That profile doesn't belongs to you!"
      redirect_to root_path
    end
  end
end
