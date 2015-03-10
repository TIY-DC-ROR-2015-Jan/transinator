require 'rails_helper'


RSpec.describe BikesController, type: :controller do

  describe "GET index" do
    render_views
    it "has a 200 status code" do
      get :index, format: :json
      expect(JSON.parse(response.body)).class == Array
    end
  end

  describe "GET close" do
    render_views
    it "has a 200 status code" do
      get :index, format: :json
      expect(JSON.parse(response.body)).class == Array
    end
  end
end
