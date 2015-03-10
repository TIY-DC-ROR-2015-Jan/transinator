class StationController <ApplicationController

def new
end

def create
  if params["Bus"]
    current_user.add_favorite_bus_stop(params[:api_id])
      if errors.any? == nil || []
        update_favorite_bus_stop(params[:api_id] params[:stop_name])
      end
  else
    current_user.add_favorite_station params[:id]
  end
end

def destroy
  current_user.delete_favorite_station params[:id]
end