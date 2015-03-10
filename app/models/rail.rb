class Rail < Station
  include HTTParty

  def self.get_user_rail_predictions(user)
    station_ids = []
    stations = user.stations.where(type: "Rail")
    stations.each { |s| station_ids << s.api_id }
    station_ids = station_ids.join
    rail_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_ids}?api_key=#{ENV["WMATA_APIKEY"]}")
  end

  #def get_user_rail_ids?
end