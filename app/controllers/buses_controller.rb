class BusesController < ApplicationController

  def index
    @bus_stop_info = Bus.get_user_bus_predictions(current_user)
    @bus_stop_info = @bus_stop_info[0]
  end

end