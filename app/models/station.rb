class Station < ActiveRecord::Base
  has_many :users
  has_many :users, through: :user_stations
end
