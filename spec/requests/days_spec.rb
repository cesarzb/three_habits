require 'rails_helper'

RSpec.describe "/days", type: :request do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Day.create! valid_attributes
      get days_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      day = Day.create! valid_attributes
      get day_url(day), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Day" do
        expect {
          post days_url,
               params: { day: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Day, :count).by(1)
      end

      it "renders a JSON response with the new day" do
        post days_url,
             params: { day: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Day" do
        expect {
          post days_url,
               params: { day: invalid_attributes }, as: :json
        }.to change(Day, :count).by(0)
      end

      it "renders a JSON response with errors for the new day" do
        post days_url,
             params: { day: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested day" do
      day = Day.create! valid_attributes
      expect {
        delete day_url(day), headers: valid_headers, as: :json
      }.to change(Day, :count).by(-1)
    end
  end
end
