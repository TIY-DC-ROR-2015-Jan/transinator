class RailsController < ApplicationController

  def index
    all_rail_db = Station.get_all_rail_db
    @rail_favorites = Rail.get_favorite_rail_predictions(current_user)
    @rail_favorites

    @all_rail_nearby = current_user.get_close_rails(all_rail_db)
    @near_rail_info = Rail.get_nearby_rail_predictions(@all_rail_nearby)
    
    #compare nearby rail to favorite rail and remove overlap from nearby rail
    # @rail_nearby = []
    # all_rail_nearby.select do |rail|
    #   @rail_favorites["Trains"].each { |e| @rail_nearby << rail if e["LocationCode"] != rail.api_id }
    # end
  
    return @near_rail_info, @rail_favorites
  end

end