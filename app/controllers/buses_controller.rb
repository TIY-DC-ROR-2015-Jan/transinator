class BusesController < ApplicationController

  include HTTParty
 

  def index
    wmatakey = File.read('.env')
    @bus_stop_info = []
    current_user.stations.where(type: "Bus").each do |stop| 
      @bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{wmatakey}")
    end
    @bus_stop_info = @bus_stop_info[0]
  end

end