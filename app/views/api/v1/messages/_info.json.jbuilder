json.id       message.id
json.content  message.content
json.user do
  json.id       message.user.id
  json.username message.user.username
end
json.match_id message.match_id
json.date     message.created_at
