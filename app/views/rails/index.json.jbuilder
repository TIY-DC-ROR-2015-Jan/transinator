get_trains = @rail_stations["Trains"]
@by_station = get_trains.group_by { |t| t["LocationName"]}


json.train_predictions @by_station.each do |station|
  json.station_name station[0]
  @trains = station[1]
  json.rail_arrivals @trains.each do |train|
    json.train_color train["Line"]
    json.train_destination train["DestinationName"]
    json.minutes_away train["Min"]
  end
end
