class Rail < Station
  include HTTParty

  def self.get_all_rail_stations
    all_stations = HTTParty.get("https://api.wmata.com/Rail.svc/json/jStations?LineCode&api_key=#{ENV["WMATA_APIKEY"]}")
    binding.pry
    all_stations["Stations"].each do |station|
      s = Station.find_or_create_by(api_id: station["Code"])
      s.update!(type: "Rail", name: station["Name"], lat: station["Lat"], long: station["Lon"])
    end
  end

  def self.get_favorite_rail_predictions(user)
    rail_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{Rail.find_user_rail_station_ids(user)}?api_key=#{ENV["WMATA_APIKEY"]}")
    return rail_info
  end

  def self.get_nearby_rail_predictions(nearby_rail)
    rail_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{Rail.get_nearby_station_ids(nearby_rail)}?api_key=#{ENV["WMATA_APIKEY"]}")
    return rail_info
  end

  def self.find_user_rail_station_ids(user)
    station_ids = []
    stations = user.stations.where(type: "Rail")
    stations.each { |s| station_ids.push(s.api_id.to_s) }
    station_ids = station_ids * ","
    station_ids
  end

  def self.get_nearby_station_ids(nearby_rail)
    station_ids = []
    nearby_rail.each { |s| station_ids.push(s.api_id.to_s)}
    station_ids = station_ids * ","
    station_ids
  end
end