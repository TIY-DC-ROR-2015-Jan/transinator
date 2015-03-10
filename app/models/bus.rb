class Bus < Station
  include HTTParty

  def self.get_user_bus_predictions(user)
    @bus_stop_info = []
    user.stations.where(type: "Bus").each do |stop| 
      @bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{ENV["WMATA_APIKEY"]}")
    end
    @bus_stop_info
  end





end