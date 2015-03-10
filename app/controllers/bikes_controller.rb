class BikesController < ApplicationController

def index
  @bikes = Bike.all.map {|bike| bike}
end

def close
  @bikes = current_user.get_close_bikes
  render :index
end


end