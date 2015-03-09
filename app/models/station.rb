class Station < ActiveRecord::Base
  has_many :user_stations
  has_many :users, through: :user_stations

end
