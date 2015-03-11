class DashboardController < ApplicationController

def show

  Bike.load_bike_stations
  Rail.get_all_rail_stations

end


def new
  @user = current_user.id
end


end
