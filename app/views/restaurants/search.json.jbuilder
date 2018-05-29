json.restaurants do
  json.array!(@restaurants) do |restaurant|
    json.name restaurant.name
    json.url restaurant_path(restaurant)
  end
end

json.tags do
  json.array!(@tags) do |tag|
    json.name "#"+tag.name
    json.url tag_path(tag)
  end
 end