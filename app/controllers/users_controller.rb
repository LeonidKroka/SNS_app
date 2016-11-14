class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update, :edit_pass]
  before_action :logged_for_action, only: [:show, :search, :index, :friends,
                                           :create_friend, :destroy_friend]

  def new
    if logged?
      @user = current_user
      @friends = get_nine_friends @user
      @post = Post.new
      @comment = Comment.new
      @posts = @user.posts.last(10).reverse
    else
      @user = User.new()
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      UserMailer.account_activation(@user).deliver_now
      @friends = get_nine_friends @user
      @post = Post.new
      @comment = Comment.new
      @posts = @user.posts.last(10).reverse
      @page = "profile"
    else
      @page = "back"
    end

    respond_to do |format|
      format.js
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @friends = get_nine_friends @user
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts.last(10).reverse
    respond_to do |format|
      format.js
    end
  end

  def edit
    @user = current_user
    respond_to do |format|
      format.js
    end
  end

  def update
    @user = current_user
    if User.new(validation_hash).valid?
      @user.update_attribute(:name, params[:user][:name])
      @user.update_attribute(:surname, params[:user][:surname])
    end
    @friends = get_nine_friends @user
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts.last(10).reverse
    respond_to do |format|
      format.js
    end
  end

  def edit_pass
    @user = current_user
    @user.authenticated?(:password, params[:user][:last_password])
    @user.update_attributes(:password => params[:user][:password],
                              :password_confirmation => params[:user][:password_confirmation])
    @friends = get_nine_friends @user
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts.last(10).reverse
    respond_to do |format|
      format.js
    end
  end

  def account_activation
  end

  def password_reset
  end

  def search
    line = params[:user][:name]
    @search = []
    User.all.each do |user|
      @search<<user if (line.include?user.name)||
                      (line.include?user.surname)||
                      (user.name.include?line)||
                      (user.name.include?line)
    end
    respond_to do |format|
      format.js
    end
  end

  def friends
    @user = User.find_by(id: (params[:id]||current_user.id))
    @friends = @user.all_friends
    respond_to do |format|
      format.js
    end
  end

  def create_friend
    relation = FriendRelation.new(friend_relation_params)
    relation.friend_id = current_user.id
    relation.save
    @user = User.find_by(id: params[:friend_relation][:user_id])
    @friends = get_nine_friends @user
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    @post = Post.new
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def destroy_friend
    @user = User.find_by(id: params[:user][:user_id])
    relation = (current_user.all_relations.find_by(friend_id: @user.id)||current_user.all_relations.find_by(user_id: @user.id))
    relation.destroy
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
    @post = Post.new
    @comment = Comment.new
    @profile = params[:user][:profile]
    if @profile == 'false'
      @friends = get_nine_friends current_user
      @user = current_user
    else
      @friends = get_nine_friends @user
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :surname, :gender, :email, :password, :password_confirmation)
    end

    def friend_relation_params
      params.require(:friend_relation).permit(:user_id)
    end

    def validation_hash
      { :name => params[:user][:name],
        :surname => params[:user][:surname],
        :gender => 'male',
        :email => 'true_email@exemple.com',
        :password => 'Validpass1',
        :password_confirmation => 'Validpass1' }
    end

    def correct_user
      redirect_to root_path unless (current_user == User.find_by(id: params[:id]))
    end
end
