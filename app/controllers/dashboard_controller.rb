class DashboardController < ApplicationController

def show

  Bike.load_bike_stations
  Rail.get_all_rail_stations
<<<<<<< HEAD
 
=======
  Bike.load_bike_stations
>>>>>>> upstream/master
end


def new
  @user = current_user.id
end


end