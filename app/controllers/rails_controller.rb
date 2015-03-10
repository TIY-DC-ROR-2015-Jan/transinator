class RailsController < ApplicationController

  def index
    @rail_stations = Rail.get_user_rail_predictions(current_user)
    @rail_stations
  end

end