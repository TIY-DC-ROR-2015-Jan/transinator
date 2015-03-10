json.array!(@bikes) do |bike|
  json.extract! bike, :name, :bikes, :empty, :id
end