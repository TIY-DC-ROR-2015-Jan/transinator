require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET show" do
    it "loads Bike data at show" do
      get :show
      expect(Bike.count).not_to eq 0
    end
  end
end
