class PostsController < ApplicationController
  def create
    @user = User.find_by(id: params[:user_id])
    @user.posts.create(post_params)
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    @post = Post.new
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:text)
    end
end
