json.topics @topics do |topic|
  json.topic do
    json.partial! 'info', topic: topic
  end
end
