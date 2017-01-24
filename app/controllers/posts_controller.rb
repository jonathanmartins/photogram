class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
