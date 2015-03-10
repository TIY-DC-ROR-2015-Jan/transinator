class RailsController < ApplicationController

  def index
    @rail_stations = Rail.get_user_rail_predictions(current_user)
    binding.pry
    @rail_stations
  end

end