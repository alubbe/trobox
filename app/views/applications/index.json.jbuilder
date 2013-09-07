json.array!(@applications) do |application|
  json.extract! application, :immo_id, :user_id, :title, :picture_url, :price, :living_space, :rooms, :address, :email, :mobile, :landline
  json.url application_url(application, format: :json)
end
