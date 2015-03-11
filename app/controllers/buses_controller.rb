class BusesController < ApplicationController

  def index
    @favorite_stop_info = Bus.get_favorite_bus_predictions(current_user)
    @favorite_stop_info 

    buses_near_user = Bus.get_nearby_bus_stops(current_user)
    stops = buses_near_user["Stops"]
    @bus_hash = Bus.make_lookup_hash(stops)
    
    stop_ids = Bus.find_nearby_bus_stop_ids(stops)
    @near_bus_predictions = Bus.nearby_bus_predictions(stop_ids)
    @near_bus_predictions


    return @favorite_stop_info, @near_bus_predictions, @bus_hash
  end

end