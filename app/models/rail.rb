class Rail < Station
  include HTTParty

  def self.get_rail_stations
    #get all rail stations and add to DB
  end

  def self.get_bus_stops
    #get all bus stops and add to DB?  Do we need search by specific location here? Sooo many bus stops...
  end

  def self.get_user_rail_predictions(user)
    rail_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{Rail.find_user_rail_station_ids(user)}?api_key=#{ENV["WMATA_APIKEY"]}")
    return rail_info
  end

  def self.find_user_rail_station_ids(user)
    station_ids = []
    stations = user.stations.where(type: "Rail")
    stations.each { |s| station_ids.push(s.api_id.to_s) }
    station_ids = station_ids * ","
    station_ids
  end
end