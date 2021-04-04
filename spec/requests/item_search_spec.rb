require 'rails_helper'

RSpec.describe "item find_one API end point", type: :request do
  before :each do
    create(:item, name: "item", unit_price: 1000.99)
    create(:item, name: "thing", unit_price: 10.99)
    create(:item, name: "stuff-n-things", unit_price: 125.99)
    create(:item, name: "another item", unit_price: 100.99)
    create(:item, name: "more item", unit_price: 100.99)
    create(:item, name: "item-that-does things", unit_price: 100.99)
  end

  describe "Happy Path" do
    describe "Search by name" do
      it "returns the first item with a matching name sorted alphabetically" do
        name = "things"
        get "/api/v1/items/find?name=#{name}"

        expect(response.status).to eq(200)
        expect(json[:data][:attributes][:name]).to eq("item-that-does things")
      end

      it "returns no object if there are no matches for the item name" do
        name = "No Match"
        get "/api/v1/items/find?name=#{name}"

        expect(response.status).to eq(200)
        expect(json[:data].count).to eq(0)
      end
    end

    describe "Search by price" do
      it "returns the first item above the minimum value sorted alphabetically" do
        min = 1
        get "/api/v1/items/find?min_price=#{min}"

        expect(response.status).to eq(200)
        expect(json[:data][:attributes][:name]).to eq("another item")
      end

      it "returns the first item below the maximum value sorted alphabetically" do
        max = 1000.50
        get "/api/v1/items/find?max_price=#{max}"

        expect(response.status).to eq(200)
        expect(json[:data][:attributes][:name]).to eq("another item")
      end

      it "returns the first item between the maximum and minimum values sorted alphabetically" do
        min = 101.50
        max = 1000.50
        get "/api/v1/items/find?max_price=#{max}&min_price=#{min}"

        expect(response.status).to eq(200)
        expect(json[:data][:attributes][:name]).to eq("stuff-n-things")
      end
    end

    describe "Edge Case" do
      it "returns no item if the minimum value is greater then all items" do
        min = 10000
        get "/api/v1/items/find?min_price=#{min}"

        expect(response.status).to eq(200)
        expect(json[:data].count).to eq(0)
      end

      it "returns no item if the maximum value is less then all items" do
        max = 0.10
        get "/api/v1/items/find?max_price=#{max}"

        expect(response.status).to eq(200)
        expect(json[:data].count).to eq(0)
      end

      it "returns no item if the maximum value is less then the minimum value" do
        min = 25
        max = 10
        get "/api/v1/items/find?min_price=#{min}&max_price=#{max}"

        expect(response.status).to eq(200)
        expect(json[:data].count).to eq(0)
      end
    end
    describe "Sad Path" do
      it "returns a 400 response if both a name and price query param are give" do
        max = 1000.50
        name = "name"
        get "/api/v1/items/find?max_price=#{max}&name=#{name}"

        expect(response.status).to eq(400)
      end

      it "returns a 400 response if the max price query param is less then 0" do
        max = -1
        get "/api/v1/items/find?max_price=#{max}"

        expect(response.status).to eq(400)
      end

      it "returns a 400 response if the min price query param is less then 0" do
        min = -1
        get "/api/v1/items/find?min_price=#{min}"

        expect(response.status).to eq(400)
      end
    end
  end
end
