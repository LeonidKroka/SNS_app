class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update, :edit_pass]
  before_action :logged_for_action, only: [:show, :search, :index, :friends,
                                           :create_friend, :destroy_friend]

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      UserMailer.account_activation(@user).deliver_now
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @friends = get_nine_friends @user
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def edit
    @user = current_user
  end

  def update
    if User.new(validation_hash).valid?
      @user = current_user
      @user.update_attribute(:name, params[:user][:name])
      @user.update_attribute(:surname, params[:user][:surname])
      redirect_to @user
    else
      redirect_to(:back)
    end
  end

  def edit_pass
    @user = current_user
    if @user.authenticated?(:password, params[:user][:last_password])
      @user.update_attributes(:password => params[:user][:password],
                              :password_confirmation => params[:user][:password_confirmation])
      redirect_to @user
    else
      redirect_to(:back)
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
  end

  def index
    @search = User.all
    render 'search'
  end

  def friends
    @user = User.find_by(id: params[:id])
    @friends = @user.all_friends
  end

  def create_friend
    relation = FriendRelation.new(friend_relation_params)
    relation.friend_id = current_user.id
    relation.save
    redirect_to(:back)
  end

  def destroy_friend
    user = User.find_by(id: params[:user][:user_id])
    relation = current_user.all_relations.find_by(friend_id: user.id)||current_user.all_relations.find_by(user_id: user.id)
    relation.destroy
    redirect_to(:back)
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
