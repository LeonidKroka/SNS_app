require 'uri'

class PostsController < ApplicationController
  before_action :logged_for_action, only: [:new, :create]
  before_action :correct_user,   only: [:destroy]

  def add_next
    @user = User.find_by(id: params[:user_id].to_i)
    @posts = @user.posts.last(10+params[:post].to_i).reverse
    @post = Post.new
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def create
    url = URI.extract(params[:post][:text])
    if url.map{|link| link.include?("utube")}.include?(false) && !(url.count==0)
      @user = current_user
    else
      @user = User.find_by(id: params[:user_id])
      @user.posts.create(post_params)
      image = @user.images.new(image_params)
      image.post_id = Post.last.id
      image.save
    end
    @posts = @user.posts.last(10).reverse
    @post = Post.new
    @comment = Comment.new
    redirect_to(:back)
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.posts.find_by(id: params[:id]).destroy
    @posts = @user.posts.last(10).reverse
    @comment = Comment.new
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  def index
    @posts = news.paginate(page: params[:page], per_page: 20).order('id DESC')
    @images = new_images.limit(11)
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def like
    (@post = Post.find_by(id: params[:id]))
    .ratings.create(user_id: params[:user_id],
                    estimator_id: current_user.id,
                    like: 1)
    respond_to do |format|
      format.js
    end
  end

  def dislike
    (@post = Post.find_by(id: params[:id]))
    .ratings.create(user_id: params[:user_id],
                    estimator_id: current_user.id,
                    dislike: 1)
    respond_to do |format|
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:text)
    end

    def image_params
      params.require(:post).permit(:image)
    end

    def correct_user
      post = Post.find_by(id: params[:id])
      redirect_to root_path unless (current_user == User.find_by(id: post.user_id))
    end
end
