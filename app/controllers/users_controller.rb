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
    flash[:error_activation] = 'Account is not activated.' unless @user.activated
  end

  def account_activation
  end

  def password_reset
  end

  def search
  end

  def friends
  end

  private
    def user_params
      params.require(:user).permit(:name, :surname, :gender, :email, :password, :password_confirmation)
    end
end
