class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stations
  has_many :stations, through: :user_stations

  DISTANCE = 2
  def get_close_bikes bikes
    close_bikes =[]
    bikes.each do |bike|
      if bike.check_distance(self) < DISTANCE
        close_bikes.push bike
      end
    end
    close_bikes
  end


end
