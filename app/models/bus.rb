class Bus < Station
  include HTTParty

  def self.get_user_bus_predictions(user)
    wmatakey = File.read('.env')
    @bus_stop_info = []
    user.stations.where(type: "Bus").each do |stop| 
      @bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{wmatakey}")
    end
    @bus_stop_info
  end





end