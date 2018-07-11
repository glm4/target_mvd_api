json.targets @targets do |target|
  json.target do
    json.partial! 'info', target: target
  end
end
