class ImagesController < ApplicationController
  def index
    @images = current_user.images
  end
end
