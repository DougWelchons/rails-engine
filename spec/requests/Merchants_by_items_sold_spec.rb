require 'rails_helper'

RSpec.describe "merchants by items sold", type: :request do
  before :each do
    seed_test_db
  end
  describe "Happy Path" do
    it "returns merchants equal to the quantity query params" do
      qty = 2
      get "/api/v1/merchants/most_items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(qty)
      expect(json[:data].first[:attributes][:name]).to eq("try again")
      expect(json[:data].second[:attributes][:name]).to eq("one more")
    end

    it "returns all merchants if the quantity query params is larger then the number of merchants" do
      qty = 15
      get "/api/v1/merchants/most_items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(6)
      expect(json[:data].first[:attributes][:name]).to eq("try again")
      expect(json[:data].second[:attributes][:name]).to eq("one more")
      expect(json[:data].third[:attributes][:name]).to eq("stand by")
      expect(json[:data].fourth[:attributes][:name]).to eq("the merchants guild")
      expect(json[:data].fifth[:attributes][:name]).to eq("the merchants for all")
      expect(json[:data].last[:attributes][:name]).to eq("Merchants 4 me")
    end
  end

  describe "Edge Cases" do
    it "does not includes merchants that do not have any successful transactions" do
      create(:merchant, name: "No Invoices")
      qty = 20
      get "/api/v1/merchants/most_items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(6)
      expect(json[:data]).to_not include("No Invoices")
    end
  end

  describe "Sad Path" do
    it "returns a 400 response if the quantity query param is less then 1" do
      qty = -1
      get "/api/v1/merchants/most_items?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is a string" do
      qty = "string"
      get "/api/v1/merchants/most_items?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is blank" do
      get "/api/v1/merchants/most_items?quantity="

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is not provided" do
      get "/api/v1/merchants/most_items"

      expect(response.status).to eq(400)
    end
  end
end
