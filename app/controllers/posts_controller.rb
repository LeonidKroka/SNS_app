require 'uri'

class PostsController < ApplicationController
  def create
    url = URI.extract(params[:post][:text])
    if url.map{|link| link.include?("utube")}.include?(false) && !(url.count==0)
      @user = current_user
      @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
      @post = Post.new
      @comment = Comment.new
      redirect_to @user
    else
      @user = User.find_by(id: params[:user_id])
      @user.posts.create(post_params)
      image = @user.images.new(image_params)
      image.post_id = Post.last.id
      image.save
      @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
      @post = Post.new
      @comment = Comment.new
      redirect_to @user
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.posts.find_by(id: params[:id]).destroy
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
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
end
