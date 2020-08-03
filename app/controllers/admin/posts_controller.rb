class Admin::PostsController < ApplicationController
  before_action :if_not_admin
  before_action :set_post, only: [:new, :create, :show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_post
    @post = Post.find(params[:id])
  end
end


