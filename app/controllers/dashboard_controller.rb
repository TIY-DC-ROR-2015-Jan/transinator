class DashboardController < ApplicationController

def show
  Rail.get_all_rail_stations
end

end