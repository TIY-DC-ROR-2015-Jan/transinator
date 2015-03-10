class DashboardController < ApplicationController

def show
  Rail.get_all_rail_stations
  Bike.load_bikes
end


def new
  @user = current_user.id
end


end