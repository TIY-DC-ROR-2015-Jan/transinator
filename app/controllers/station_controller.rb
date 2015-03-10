class StationController <ApplicationController

def new
end

def create
  if params[:type] == "bus"
    current_user.add_favorite_bus_stop(params[:api_id].to_i)
      if errors.any? == nil || []
        current_user.update_favorite_bus_stop(params[:api_id].to_i)
      end
  else
    current_user.add_favorite_station params[:id].to_i
   
  end
  head :no_content
end

def destroy
  current_user.delete_favorite_station params[:id].to_i
end
end