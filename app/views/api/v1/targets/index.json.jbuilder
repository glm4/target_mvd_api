json.targets do
  json.array! @targets, partial: 'info', as: :target
end
