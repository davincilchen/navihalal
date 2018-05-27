json.restaurants do
  json.array!(@restaurants) do |restaurant|
    json.name restaurant.name
    json.url restaurant_path(restaurant)
  end
end