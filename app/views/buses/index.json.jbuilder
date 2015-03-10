

json.bus_arrivals @bus_stop_info.each do |stop|
  json.stop_name stop["StopName"]
  @predictions = stop["Predictions"]
  json.predictions @predictions do |p|
    json.route_id p["RouteID"]
    json.direction_text p["DirectionText"]
    json.minutes p["Minutes"]
  end
end














