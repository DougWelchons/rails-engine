require 'rails_helper'

RSpec.describe "Items by revenue", type: :request do
  before :each do
    seed_test_db
  end
  describe "Happy Path" do
    it "returns 10 items by default, ordered by revenue" do
      get "/api/v1/revenue/items"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(10)
      expect(json[:data][0][:attributes][:name]).to eq("Item 11")
      expect(json[:data][1][:attributes][:name]).to eq("Item 18")
      expect(json[:data][2][:attributes][:name]).to eq("Item 5")
      expect(json[:data][3][:attributes][:name]).to eq("Item 7")
      expect(json[:data][4][:attributes][:name]).to eq("Item 8")
      expect(json[:data][5][:attributes][:name]).to eq("Item 17")
      expect(json[:data][6][:attributes][:name]).to eq("Item 10")
      expect(json[:data][7][:attributes][:name]).to eq("Item 12")
      expect(json[:data][8][:attributes][:name]).to eq("Item 4")
      expect(json[:data][9][:attributes][:name]).to eq("Item 16")
    end

    it "returns items equal to the quantity query params if provided" do
      qty = 2
      get "/api/v1/revenue/items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(qty)
      expect(json[:data][0][:attributes][:name]).to eq("Item 11")
      expect(json[:data][1][:attributes][:name]).to eq("Item 18")
    end

    it "returns all items if the quantity query params is larger then the number of items" do
      qty = 50
      get "/api/v1/revenue/items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(11)
      expect(json[:data][0][:attributes][:name]).to eq("Item 11")
      expect(json[:data][1][:attributes][:name]).to eq("Item 18")
      expect(json[:data][2][:attributes][:name]).to eq("Item 5")
      expect(json[:data][3][:attributes][:name]).to eq("Item 7")
      expect(json[:data][4][:attributes][:name]).to eq("Item 8")
      expect(json[:data][5][:attributes][:name]).to eq("Item 17")
      expect(json[:data][6][:attributes][:name]).to eq("Item 10")
      expect(json[:data][7][:attributes][:name]).to eq("Item 12")
      expect(json[:data][8][:attributes][:name]).to eq("Item 4")
      expect(json[:data][9][:attributes][:name]).to eq("Item 16")
      expect(json[:data][10][:attributes][:name]).to eq("Item 19")
    end
  end

  describe "Edge Cases" do
    it "does not includes items that do not have any successful transactions" do
      create(:item, name: "No Invoices")
      qty = 20
      get "/api/v1/revenue/items?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(11)
      expect(json[:data]).to_not include("No Invoices")
    end
  end

  describe "Sad Path" do
    it "returns a 400 response if the quantity query param is less then 1" do
      qty = -1
      get "/api/v1/revenue/items?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is a string" do
      qty = "string"
      get "/api/v1/revenue/items?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is blank" do
      get "/api/v1/revenue/items?quantity="

      expect(response.status).to eq(400)
    end
  end
end
