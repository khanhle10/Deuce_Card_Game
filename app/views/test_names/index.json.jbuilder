json.array!(@test_names) do |test_name|
  json.extract! test_name, :id, :name
  json.url test_name_url(test_name, format: :json)
end
