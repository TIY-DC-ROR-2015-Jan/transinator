@trains = @rail_stations["Trains"]

json.rail_arrivals @trains.each do |train|
  json.train_color train["Line"]
  json.train_destination train["DestinationName"]
  json.minutes_away train["Min"]
end