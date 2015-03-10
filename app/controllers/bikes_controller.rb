class BikesController < ApplicationController

  def index
    @bikes = Bike.all.map {|bike| bike}
  end

  def close
    @favorite_bikes = current_user.stations.where(type: "Bike").map {|bike| bike}
    @bikes = current_user.get_close_bikes
    render :index
  end

end