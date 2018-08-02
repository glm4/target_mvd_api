class TopicIconUploader < ImageUploaderBase
  include CarrierWave::MiniMagick

  process resize_to_fill: [75, 75]
end
