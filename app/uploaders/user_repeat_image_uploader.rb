# encoding: utf-8
require 'carrierwave/processing/mime_types'

class UserRepeatImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type
  before :cache, :set_model_width_height
  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :aligned, :if => :transform_params_set? do
    process :align
  end

  version :large, from_version: :aligned, :if => :transform_params_set? do
    process resize_to_fit: [ENV['LARGE_FIT_SIZE'].to_i, ENV['LARGE_FIT_SIZE'].to_i]
  end

  version :medium, from_version: :large, :if => :transform_params_set? do
    process resize_to_fit: [ENV['MEDIUM_FIT_SIZE'].to_i, ENV['MEDIUM_FIT_SIZE'].to_i]
  end

  version :thumb, from_version: :medium, :if => :transform_params_set? do
    process resize_to_fit: [ENV['THUMB_FIT_SIZE'].to_i, ENV['THUMB_FIT_SIZE'].to_i]
  end

  private

  def set_model_width_height(new_file)
    if model.width.blank? || model.height.blank?
      magick = ::MiniMagick::Image.read(new_file)
      model.width = magick[:width]
      model.height = magick[:height]
    end
  end

  #Methods used to determine if aligned versions of the images should be created.
  def transform_params_not_set?(new_file)
    !transform_params_set?(new_file)
  end
  def transform_params_set?(new_file)
    model.points.present?
  end

  #perform the scale rotation and transform with mini_magick
  def align
    raise ArgumentError, "Insufficient points. You need at least 2 control points in each image to be able to perform alignment" if model.points.length<2
    himg = model.historic_image
    manipulate! do |img|
      img.combine_options do |cmd|
        cmd.define "distort:viewport=#{model.repeat_pair.repeat_image.width}x#{model.repeat_pair.repeat_image.height}+0+0"
        cmd.distort("Affine", build_magick_points_params(model.points,model.repeat_pair.repeat_image.points))
      end
      img = yield(img) if block_given?
      img
    end
  end

  def build_magick_points_params(points1, points2)
    raise ArgumentError, "Both sets of points must have the same number of elements" if points1.length!=points2.length
    points1_grouped = points1.group_by(&:label)
    points2_grouped = points2.group_by(&:label)
    magick_param = ""
    points2_grouped.each do |k,_|
      magick_param += "#{points1_grouped[k][0].x},#{points1_grouped[k][0].y} #{points2_grouped[k][0].x},#{points2_grouped[k][0].y} "
    end
    magick_param
  end

end
