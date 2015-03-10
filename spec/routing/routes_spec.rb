require 'rails_helper'

RSpec.describe "routes for dashboard", :type => :routing do
  describe "dashboard routes" do
    it "routes /dashboard to dashboard show" do
      expect(get("/dashboard")).to route_to("dashboard#show")
    end

    it "routes /dashboard/station/new to dashboard new" do
      expect(get("/dashboard/station/new")).to route_to("station#new")
    end

    it "routes /dashboard/station/:id to dashboard create" do
      expect(post("/dashboard/station")).to route_to("station#create")
    end
  end

end