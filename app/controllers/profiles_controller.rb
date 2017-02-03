class ProfilesController < ApplicationController
  def show
    @posts = User.find_by_username(params[:username]).posts.order('created_at DESC').page(params[:page])
  end

  private
end
