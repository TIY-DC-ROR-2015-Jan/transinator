class DashboardController < ApplicationController

def show
  Bike.load_bikes
  
end


def new
  @user = current_user.id
end


end