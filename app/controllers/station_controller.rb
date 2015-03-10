class StationController <ApplicationController

def new
end

def create
  current_user.add_favorite_station params[:id]
end

def destroy
  current_user.delete_favorite_station params[:id]
end