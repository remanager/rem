json.array!(@towns) do |town|
  json.extract! town, :id, :postcode, :name
  json.url town_url(town, format: :json)
end
