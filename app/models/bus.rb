class Bus < Station
  include HTTParty

  BUSDISTANCE =  805 #meters (almost .5 mile)

  def self.get_nearby_bus_stops(user)
    nearby_buses = HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?Lat=#{user.lat.to_f}&Lon=#{user.long.to_f}&Radius=#{BUSDISTANCE}&api_key=#{ENV["WMATA_APIKEY"]}")
    nearby_buses
  end

  def self.find_nearby_bus_stop_ids(buses)
    stop_ids = []
    buses.each do |stop|
      stop_ids.push(stop["StopID"])
    end
    stop_ids
  end

  def self.nearby_bus_predictions(stop_ids)
    near_bus_info = []
    stop_ids.each do |id| 
      near_bus_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{id}&api_key=#{ENV["WMATA_APIKEY"]}")
    end
    near_bus_info
  end

  def self.get_favorite_bus_predictions(user)
    bus_stop_info = []
    user.stations.where(type: "Bus").each do |stop| 
      bus_stop_info << HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopID=#{stop.api_id}&api_key=#{ENV["WMATA_APIKEY"]}")
    end
    bus_stop_info
  end

  def self.make_lookup_hash(buses)
    stop_lookup_hash = {}
    buses.each do |stop|
      name = stop["Name"]  
      id = stop["StopID"]
      stop_lookup_hash.store(name, id)  
    end
    stop_lookup_hash
  end



end