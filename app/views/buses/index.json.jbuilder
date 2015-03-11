unless @favorite_stop_info == nil
  json.favorite_arrivals @favorite_stop_info.each do |stop|
    json.stop_name stop["StopName"]
    begin
      json.api_id Bus.find_by(:name => stop["StopName"]).api_id 
      json.station_id Bus.find_by(:name => stop["StopName"]).id
    rescue
      next
    ensure
      @predictions = stop["Predictions"]
      json.predictions @predictions do |p|
        json.route_id p["RouteID"]
        json.direction_text p["DirectionText"]
        json.minutes p["Minutes"]
      end
    end
  end
end


json.nearby_arrivals @near_bus_predictions.each do |stop|
  json.stop_name stop["StopName"]
  begin
    json.api_id @bus_hash[(stop["StopName"].upcase)]
  rescue
    next
  ensure
    @predictions = stop["Predictions"]
    json.predictions @predictions do |p|
      json.route_id p["RouteID"]
      json.direction_text p["DirectionText"]
      json.minutes p["Minutes"]
    end
  end
end














