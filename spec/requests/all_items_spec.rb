require 'rails_helper'

RSpec.describe "all items API end point", type: :request do
  before :each do
    @items = create_list(:item, 100)
  end

  describe "Happy Path" do
    it "returens items equal to the per_page value" do
      per_page = 10
      get "/api/v1/items?per_page=#{per_page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(per_page)
      expect(json[:data].first[:id].to_i).to eq(@items.first.id)
      expect(json[:data].last[:id].to_i).to eq(@items[per_page - 1].id)
    end

    it "returens 20 items by default" do
      get "/api/v1/items"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@items.first.id)
      expect(json[:data].last[:id].to_i).to eq(@items[19].id)
    end

    it "returens the next 20 items if page 2 is requested" do
      page = 2
      get "/api/v1/items?page=#{page}"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@items[20].id)
      expect(json[:data].last[:id].to_i).to eq(@items[39].id)
    end

    it "returens the next 10 items if page 2 & 10 items_per_page is requested" do
      per_page = 10
      page = 2
      get "/api/v1/items?per_page=10&page=#{page}"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(parsed[:data].count).to eq(10)
      expect(json[:data].first[:id].to_i).to eq(@items[10].id)
      expect(json[:data].last[:id].to_i).to eq(@items[19].id)
    end
  end

  describe "Edge Cases" do
    it "returns all items if per page is larger then the number of items" do
      per_page = 200
      get "/api/v1/items?per_page=#{per_page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(100)
    end

    it "returns all remaing items if page_count is the last page" do
      per_page = 30
      page = 4
      get "/api/v1/items?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(10)
      expect(json[:data].first[:id].to_i).to eq(@items[90].id)
      expect(json[:data].last[:id].to_i).to eq(@items[99].id)
    end

    it "returns an no objects if page count is too high" do
      per_page = 125
      page = 2
      get "/api/v1/items?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(0)
    end
  end

  describe "Sad Path" do
    it "returns page 1 if quary param for page is less then 1" do
      per_page = 10
      page = -1
      get "/api/v1/items?per_page=#{per_page}&page=#{page}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(per_page)
      expect(json[:data].first[:id].to_i).to eq(@items.first.id)
      expect(json[:data].last[:id].to_i).to eq(@items[per_page - 1].id)
    end

    it "returns the default if quary params are blank" do
      get "/api/v1/items?per_page=&page="

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(20)
      expect(json[:data].first[:id].to_i).to eq(@items.first.id)
      expect(json[:data].last[:id].to_i).to eq(@items[19].id)
    end
  end
end
