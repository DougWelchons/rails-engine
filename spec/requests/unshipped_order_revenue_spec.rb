require 'rails_helper'

RSpec.describe "Unshiped Revenue", type: :request do
  before :each do
    seed_test_db
  end

  describe "Happy Path" do
    it "returns 10 unshipped invoices ranked by potential revenue as the default" do
      get "/api/v1/revenue/unshipped"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(10)
      expect(json[:data][0][:attributes]).to eq({:potential_revenue=>"20770.0"})
      expect(json[:data][1][:attributes]).to eq({:potential_revenue=>"4451.0"})
      expect(json[:data][2][:attributes]).to eq({:potential_revenue=>"2025.0"})
      expect(json[:data][3][:attributes]).to eq({:potential_revenue=>"1891.0"})
      expect(json[:data][4][:attributes]).to eq({:potential_revenue=>"1500.0"})
      expect(json[:data][5][:attributes]).to eq({:potential_revenue=>"1069.75"})
      expect(json[:data][6][:attributes]).to eq({:potential_revenue=>"1000.0"})
      expect(json[:data][7][:attributes]).to eq({:potential_revenue=>"385.5"})
      expect(json[:data][8][:attributes]).to eq({:potential_revenue=>"169.29"})
      expect(json[:data][9][:attributes]).to eq({:potential_revenue=>"120.0"})
    end

    it "returns unshipped invoices equal to the quantity query params if provided" do
      qty = 2
      get "/api/v1/revenue/unshipped?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(2)
      expect(json[:data][0][:attributes]).to eq({:potential_revenue=>"20770.0"})
      expect(json[:data][1][:attributes]).to eq({:potential_revenue=>"4451.0"})
    end

    it "returns all of the unshipped invoices if the quantity query params are greater then the number of unshipped invoices" do
      qty = 50
      get "/api/v1/revenue/unshipped?quantity=#{qty}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(11)
      expect(json[:data][0][:attributes]).to eq({:potential_revenue=>"20770.0"})
      expect(json[:data][1][:attributes]).to eq({:potential_revenue=>"4451.0"})
      expect(json[:data][2][:attributes]).to eq({:potential_revenue=>"2025.0"})
      expect(json[:data][3][:attributes]).to eq({:potential_revenue=>"1891.0"})
      expect(json[:data][4][:attributes]).to eq({:potential_revenue=>"1500.0"})
      expect(json[:data][5][:attributes]).to eq({:potential_revenue=>"1069.75"})
      expect(json[:data][6][:attributes]).to eq({:potential_revenue=>"1000.0"})
      expect(json[:data][7][:attributes]).to eq({:potential_revenue=>"385.5"})
      expect(json[:data][8][:attributes]).to eq({:potential_revenue=>"169.29"})
      expect(json[:data][9][:attributes]).to eq({:potential_revenue=>"120.0"})
      expect(json[:data][10][:attributes]).to eq({:potential_revenue=>"101.0"})
    end
  end

  describe "Sad Path" do
    it "returns a 400 response if the quantity query param is less then 1" do
      qty = -1
      get "/api/v1/revenue/unshipped?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is a string" do
      qty = "string"
      get "/api/v1/revenue/unshipped?quantity=#{qty}"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the quantity query param is blank" do
      get "/api/v1/revenue/unshipped?quantity="

      expect(response.status).to eq(400)
    end
  end
end
