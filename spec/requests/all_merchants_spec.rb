require 'rails_helper'

RSpec.describe "all merchants API end point", type: :request do
  before :each do
    seed_test_db
  end

  describe "Happy Path" do
    it "returens merchants equal to the per_page value" do
      per_page = 10
      get "/api/v1/merchants?per_page=#{per_page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(per_page)
      expect(json[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant10.id)
    end

    it "returens 20 merchants by default" do
      get "/api/v1/merchants"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant20.id)
    end

    it "returens the next 20 merchants if page 2 is requested" do
      page = 2
      get "/api/v1/merchants?page=#{page}"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(5)
      expect(json[:data].first[:id].to_i).to eq(@merchant21.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant25.id)
    end

    it "returens the next 10 merchants if page 2 & 10 merchants_per_page is requested" do
      per_page = 10
      page = 2
      get "/api/v1/merchants?per_page=#{per_page}&page=#{page}"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(10)
      expect(json[:data].first[:id].to_i).to eq(@merchant11.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant20.id)
    end
  end

  describe "Edge Cases" do
    it "returns all merchants if per page is larger then the number of merchants" do
      per_page = 200
      get "/api/v1/merchants?per_page=#{per_page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(25)
    end

    it "returns all remaing merchants if page_count is the last page" do
      per_page = 10
      page = 3
      get "/api/v1/merchants?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(5)
      expect(json[:data].first[:id].to_i).to eq(@merchant21.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant25.id)
    end

    it "returns an no objects if page count is too high" do
      per_page = 125
      page = 2
      get "/api/v1/merchants?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(0)
    end
  end

  describe "Sad Path" do
    it "returns page 1 if query param for page is less then 1" do
      per_page = 10
      page = -1
      get "/api/v1/merchants?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(per_page)
      expect(json[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant10.id)
    end

    it "returns 20 merchants per page if query param for per_page is less then 1" do
      per_page = -1
      page = 1
      get "/api/v1/merchants?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant20.id)
    end

    it "returns the default if query params are blank" do
      get "/api/v1/merchants?per_page=&page="

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(json[:data].last[:id].to_i).to eq(@merchant20.id)
    end
  end
end
