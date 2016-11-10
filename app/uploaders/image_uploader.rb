# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :avatar do
    process resize_to_fill: [150,250]
  end

  version :list do
    process resize_to_fill: [100,100]
  end

  version :thumb do
    process resize_to_fill: [60,60]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

end
