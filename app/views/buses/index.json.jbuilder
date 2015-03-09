@predictions = @bus_stop_info["Predictions"]

json.predictions @predictions do |p|
  json.route_id p["RouteID"]
  json.direction_text p["DirectionText"]
  json.minutes p["Minutes"]
end

json.stop_name @bus_stop_info["StopName"]












