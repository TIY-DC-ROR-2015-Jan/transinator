
@favorite_stop_info
json.favorite_arrivals @favorite_stop_info.each do |stop|
  json.stop_name stop["StopName"]
  @predictions = stop["Predictions"]
  json.predictions @predictions do |p|
    json.route_id p["RouteID"]
    json.direction_text p["DirectionText"]
    json.minutes p["Minutes"]
  end
end


@buses_near_user

get_buses = @buses_near_user["Stops"]
@by_stop = get_buses.group_by { |s| s["Name"]}

json.favorite_predictions @by_stop.each do |stop|
  json.stop_name stop[0]
  @stops = stop[1]
  json.bus_arrivals @stops.each do |bus|
    json.route_id bus["RouteID"]
    json.direction_text bus["DirectionText"]
    json.minutes_away bus["Minutes"]
  end
end














