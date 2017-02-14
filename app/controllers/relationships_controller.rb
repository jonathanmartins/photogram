class RelationshipsController < ApplicationController
  before_action :set_user, only: [:follow_user, :unfollow_user]

  def follow_user
    if current_user.follow @user.id
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unfollow_user
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
