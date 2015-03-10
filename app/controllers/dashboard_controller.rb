class DashboardController < ApplicationController

def show
  Rail.get_all_rail_stations
  Bike.load_bike_stations
end


def new
  @user = current_user.id
end


end