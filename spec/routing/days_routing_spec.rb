require "rails_helper"

RSpec.describe Api::V1::DaysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/days").to route_to("api/v1/days#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/days/1").to route_to("api/v1/days#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/days").to route_to("api/v1/days#create")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/days/1").to route_to("api/v1/days#destroy", id: "1")
    end
  end
end
