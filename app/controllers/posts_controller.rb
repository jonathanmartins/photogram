class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page(params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Successfully updated!"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Your post couldn't be updated"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted."
      redirect_to posts_path
    end
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:caption, :image)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def owned_post
      unless current_user == @post.user
        flash[:alert] = "That post doesn't belongs to you!"
        redirect_to root_path
      end
    end
end
