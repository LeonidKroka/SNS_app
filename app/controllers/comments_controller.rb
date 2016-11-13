class CommentsController < ApplicationController
  def create
    @user = User.find_by(id: params[:user_id])
    comment = current_user.comments.create(post_params)
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    @comment = Comment.new
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    puts params.inspect
    @user = User.find_by(id: params[:user_id])
    current_user.comments.find_by(id: params[:id]).destroy
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    @comment = Comment.new
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  private
    def post_params
      params.require(:comment).permit(:post_id, :text)
    end
end
