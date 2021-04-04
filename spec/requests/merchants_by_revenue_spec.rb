require 'rails_helper'

RSpec.describe "merchants by revenue", type: :request do
  before :each do
    seed_test_db
  end

  describe "Happy Path" do
    it "returns the top 5 merchants sorted by revenue as the default" do
      get "/api/v1/revenue/merchants"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(5)
      expect(json[:data].first[:attributes][:name]).to eq("stand by")
      expect(json[:data].second[:attributes][:name]).to eq("try again")
      expect(json[:data].third[:attributes][:name]).to eq("Merchants 4 me")
      expect(json[:data].fourth[:attributes][:name]).to eq("the merchants for all")
      expect(json[:data].fifth[:attributes][:name]).to eq("the merchants guild")
    end

    it "returns merchants equal to the quantity query params sorted by revenue" do
      qty = 2
      get "/api/v1/revenue/merchants?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(2)
      expect(json[:data].first[:attributes][:name]).to eq("stand by")
      expect(json[:data].second[:attributes][:name]).to eq("try again")
    end

    it "returns all merchants if the quantity query params is larger then the number of merchants sorted by revenue" do
      qty = 50
      get "/api/v1/revenue/merchants?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(6)
    end
  end

  describe "Edge Cases" do
    it "does not includes merchants that do not have any successful transactions" do
      create(:merchant, name: "No Invoices")
      qty = 20
      get "/api/v1/revenue/merchants?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(6)
      expect(json[:data]).to_not include("No Invoices")
    end
  end

  describe "Sad Path" do
    it "uses the default quantity if the quantity query param is less then 1" do
      qty = -1
      get "/api/v1/revenue/merchants?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(5)
    end

    it "uses the default quantity if the quantity query param is blank" do
      get "/api/v1/revenue/merchants?quantity="

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(5)
    end
  end
end
