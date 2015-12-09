json.array!(@deuces) do |deuce|
  json.extract! deuce, :id, :player_count, :name, :player1, :player2, :player3, :player4
  json.url deuce_url(deuce, format: :json)
end
