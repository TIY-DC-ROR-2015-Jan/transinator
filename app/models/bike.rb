class Bike < Station
  include HTTParty
  base_uri 'http://www.capitalbikeshare.com'
  def self.get_bike_stations
    data = get('/data/stations/bikeStations.xml')

    data["stations"]["station"].each do |station|
      s = Station.find_or_create_by(terminalName: station["terminalName"].to_i)
      s.update! name: s["name"], lat: s["lat"], long: s["long"], bikes: s["nbBikes"], s["nbEmptyDocks"]
    end
  end
end