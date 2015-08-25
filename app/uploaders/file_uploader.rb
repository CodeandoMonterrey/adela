# encoding: utf-8
class FileUploader < CarrierWave::Uploader::Base
  if Rails.env.test? || Rails.env.development?
    storage :file
  else
    storage :aws
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(csv xls xlsx)
  end
end
