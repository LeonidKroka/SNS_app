class MessagesController < ApplicationController
  before_action :logged_for_action
  
  def index
    @messages = Message.where('CAST(receiver_id AS text) LIKE ?', current_user.id.to_s).order('id DESC')
  end

  def create
    @user = User.find_by(id: params[:user_id])
    current_user.messages.create(text: params[:messadge][:text], receiver_id: @user.id)
    respond_to do |format|
      format.js
    end
  end
end
