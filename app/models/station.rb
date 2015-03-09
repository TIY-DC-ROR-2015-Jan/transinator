class Station < ActiveRecord::Base
  has_many :user_stations
  has_many :users, through: :user_stations


  def check_distance 
    user_lat = current_user.lat.to_f
    user_long = current_user.long.to_f
    station_lat = self.lat.to_f
    station_long = self.long.to_f
    distance = Haversine.distance(user_lat, user_long, station_lat, station_long)
  end
end
