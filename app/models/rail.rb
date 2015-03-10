class Rail < Station
  include HTTParty

  def self.get_user_rail_predictions(user)
    station_ids = []
    stations = user.stations.where(type: "Rail")
    stations.each { |s| station_ids.push(s.api_id.to_s) }
    station_ids = station_ids * ","
    rail_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_ids}?api_key=#{ENV["WMATA_APIKEY"]}")
    return rail_info
  end

  #def get_user_rail_ids?
end