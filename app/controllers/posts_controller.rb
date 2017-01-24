class PostsController < ApplicationController
  def index
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
