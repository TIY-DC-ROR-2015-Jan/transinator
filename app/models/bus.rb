class Bus < Station
  include HTTParty

  def self.get_nearby_bus_stops(user)
    HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?#{user.lat.to_i}&#{user.long.to_i}&#{Station.search_radius}&api_key=#{ENV["WMATA_APIKEY"]}")
    #get all bus stops and add to DB?  Do we need search by specific location here? Sooo many bus stops...
  end

  def self.get_user_bus_predictions(user)
    @bus_stop_info = []
    user.stations.where(type: "Bus").each do |stop| 
      @bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{ENV["WMATA_APIKEY"]}")
    end
    @bus_stop_info
  end


end