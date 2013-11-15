json.array!(@users) do |user|
  json.extract! user, :netid, :admin
  json.url user_url(user, format: :json)
end
