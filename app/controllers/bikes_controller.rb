class BikesController < ApplicationController

def index
  @bikes = current_user.get_close_bikes Bike.all, 0.5
  binding.pry
end

end