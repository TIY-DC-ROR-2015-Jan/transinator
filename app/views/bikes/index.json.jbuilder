json.favorite(@favorite_bikes) do |bike|
  json.extract! bike, :name, :bikes, :empty, :id
end

json.nearby(@bikes) do |bike|
  json.extract! bike, :name, :bikes, :empty, :id
end