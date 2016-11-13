class UsersController < ApplicationController
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

  def account_activation
  end

  def password_reset
  end

  def search
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
end
