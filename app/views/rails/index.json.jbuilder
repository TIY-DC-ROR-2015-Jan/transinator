unless @rail_favorites["statusCode"] = "404"
  get_trains = @rail_favorites["Trains"]
  @by_station = get_trains.group_by { |t| t["LocationName"]}

  json.favorite_predictions @by_station.each do |station|
    json.station_name station[0]
    @trains = station[1]
    json.rail_arrivals @trains.each do |train|
      json.train_color train["Line"]
      json.train_destination train["DestinationName"]
      json.minutes_away train["Min"]
    end
  end
end

get_trains = @near_rail_info["Trains"]
@close_by_station = get_trains.group_by { |t| t["LocationName"]}

json.nearby_predictions @close_by_station do |rail|
  json.station_name rail[0]
  @trains = rail[1]
  json.rail_arrivals @trains.each do |train|
    json.train_color train["Line"]
    json.train_destination train["DestinationName"]
    json.minutes_away train["Min"]
  end
end