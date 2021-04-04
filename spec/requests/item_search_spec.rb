require 'rails_helper'

RSpec.describe "item find_one API end point" do
  before :each do
    create(:item, name: "item", unit_price: 1000.99)
    create(:item, name: "thing", unit_price: 10.99)
    create(:item, name: "stuff-n-things", unit_price: 125.99)
    create(:item, name: "another item", unit_price: 100.99)
    create(:item, name: "more item", unit_price: 100.99)
    create(:item, name: "item-that-does things", unit_price: 100.99)
  end

  it "returns one item with a matching name" do
    name = "things"
    get "/api/v1/items/find?name=#{name}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].keys).to eq([:id, :type, :attributes])
  end

  it "returns one item based on a minimum value" do
    price = "1"
    get "/api/v1/items/find?min_price=#{price}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].keys).to eq([:id, :type, :attributes])
  end

  it "returns one item based on a maximum value" do
    price = "1000.50"
    get "/api/v1/items/find?max_price=#{price}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].keys).to eq([:id, :type, :attributes])
  end

  it "returns one item when both a min and max value are given" do
    min = "100.50"
    max = "1000.50"
    get "/api/v1/items/find?max_price=#{max}&min_price=#{min}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].keys).to eq([:id, :type, :attributes])
  end

  it "return an error if both a name and price range are give" do
    max = "1000.50"
    name = "name"
    get "/api/v1/items/find?max_price=#{max}&name=#{name}"

    expect(response.status).to eq(400)
  end
end
