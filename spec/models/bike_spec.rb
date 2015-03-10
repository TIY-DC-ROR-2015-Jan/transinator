require 'rails_helper'

RSpec.describe Bike, type: :model do
  it "loads all the bike stations into the database" do
    bikes = Bike.load_bike_stations
    expect(bikes.count).to be > 0 
  end
end
