# frozen_string_literal: true

require 'carrierwave/processing/mini_magick'

# Carrierwave main Image Uploader to be use for file fields
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave if Rails.env.production?
  
  # Choose what kind of storage to use for this uploader:
  storage :file unless Rails.env.production?
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
