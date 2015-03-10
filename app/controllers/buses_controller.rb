class BusesController < ApplicationController

  def index
    @favorite_stop_info = Bus.get_favorite_bus_predictions(current_user)
    @favorite_stop_info 

    @buses_near_user = Bus.get_nearby_bus_stops(current_user)
    @buses_near_user


    return @favorite_stop_info, @buses_near_user
  end

end