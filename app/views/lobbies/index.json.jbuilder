json.array!(@lobbies) do |lobby|
  json.extract! lobby, :id
  json.url lobby_url(lobby, format: :json)
end
