class Bike < Station
  include HTTParty
  base_uri 'http://www.capitalbikeshare.com'
  
  def self.get_bike_stations
    data = get('/data/stations/bikeStations.xml')

    data["stations"]["station"].each do |station|
      s = Station.find_or_create_by(terminalName: station["terminalName"].to_i)
      s.update! type: "Bike", name: station["name"], lat: station["lat"], long: station["long"], bikes: station["nbBikes"], empty: station["nbEmptyDocks"]    
    end
  end


end