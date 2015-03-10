class BikesController < ApplicationController

def index
  @bikes = Bike.load_bike_stations  
end

def close
  @bikes = current_user.get_close_bikes
end


end