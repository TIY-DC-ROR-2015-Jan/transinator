require 'rails_helper'

RSpec.describe "routes for Widgets", :type => :routing do
  describe "dashboard routes" do
    it "routes /dashboard to dashboard show" do
      expect(get("/dashboard")).to route_to("dashboard#show")
    end

    it "routes /dashboard/station/new to dashboard new" do
      expect(get("/dashboard")).to route_to("dashboard#show")
    end
  end

end