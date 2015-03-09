class BikeController < ApplicationController

def index
  @bikes = Bike.get_bike_stations
  binding.pry
end

end