class BusesController < ApplicationController

  def index
    @bus_stop_info = Bus.get_user_bus_predictions(current_user)
    @bus_stop_info 
  end

end