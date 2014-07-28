json.array!(@properties) do |property|
  json.extract! property, :id, :ref, :town_id, :user_id, :category_id, :detail_id
  json.url property_url(property, format: :json)
end
