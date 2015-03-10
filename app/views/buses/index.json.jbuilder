@predictions = @bus_stop_info["Predictions"]
binding.pry

json.stop_name @bus_stop_info["StopName"]
json.predictions @predictions do |p|
  json.route_id p["RouteID"]
  json.direction_text p["DirectionText"]
  json.minutes p["Minutes"]
end













