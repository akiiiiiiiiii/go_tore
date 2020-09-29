class PostsController < ApplicationController
  before_action :authenticate_user!,only: [:new, :index, :show, :edit, :update, :destroy, :create]

def top
end

def new
  	@post = Post.new
end

def index
	  @post = Post.new
    # @posts = Post.page(params[:page]).reverse_order .per(13)
    @user = current_user
    @search = Post.ransack(params[:q])
    @posts = @search.result.page(params[:page]).reverse_order.per(13)
end

def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
end

def edit
    @post = Post.find(params[:id])
end

def update
    post = Post.find(params[:id])
    if
    post.update(post_params)
    redirect_to post_path(post.id), notice: "Post was successfully updated."
    end
end

def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
end

def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
end

private
  def post_params
      params.require(:post).permit(:title, :body, :place, :post_image)
  end

  def user_params
      params.require(:user).permit(:name, :profile_image)
  end
end