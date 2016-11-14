class ImagesController < ApplicationController
  before_action :logged_for_action

  def index
    @images = current_user.images
    respond_to do |format|
      format.js
    end
  end
end
