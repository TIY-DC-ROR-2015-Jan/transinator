class DashboardController < ApplicationController

def show
  Bike.load_bikes
  
end

end