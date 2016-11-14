class SessionsController < ApplicationController
  before_action :logged_for_action, only: :destroy
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticated?(:password, params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      @page = 'profile'
      @user = user
      @friends = get_nine_friends @user
      @post = Post.new
      @comment = Comment.new
      @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    else
      @page = 'back'
      flash.now[:error] = 'Invalid login/password'
      @user = User.new()
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    log_out if logged?
    redirect_to root_path
  end
end
