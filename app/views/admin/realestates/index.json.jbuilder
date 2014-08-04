json.array!(@realestates) do |realestate|
  json.extract! realestate, :id, :name, :description, :address, :user_id
  json.url realestate_url(realestate, format: :json)
end
