class ImageUploaderBase < CarrierWave::Uploader::Base

  def content_type_whitelist
    %r{image\/}
  end
end
