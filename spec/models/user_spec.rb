require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create email: "t1@example.com", password: "password", lat: "38.8542", long: "-77.04903" 
  end
  it "gets close bikes" do
    Bike.load_bike_stations
    bikes = @user.get_close_bikes
    expect(bikes.count).not_to eq 0
  end

  # it "get close rails" do
  #   Rail.get_all_rail_stations
  #   rails = @user.get_close_rails Rail.all
  #   expect(rails.count).not_to eq 0
  # end

  it "adds and deletes favorite station" do
    station = Station.create
    @user.add_favorite_station station.id
    expect(@user.stations.count).not_to eq 0
    @user.delete_favorite_station station.id
    expect(@user.stations.count).to eq 0
  end

  

end
