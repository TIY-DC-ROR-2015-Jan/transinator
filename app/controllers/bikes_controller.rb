class BikesController < ApplicationController

def index
  Bike.get_bike_stations
  @bikes = current_user.get_close_bikes Bike.all
end

end