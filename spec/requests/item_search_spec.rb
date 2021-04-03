require 'rails_helper'

RSpec.describe "item find_one API end point" do
  before :each do
      create_list(:item, 100)
  end

  it "returns one item with a matching name" do
    name = "1"
    get "/api/v1/items/find?name=#{name}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].count).to eq(1)
  end

  it "returns one item based on a minimum value" do
    price = "1"
    get "/api/v1/items/find?min_price=#{price}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].count).to eq(1)
  end

  it "returns one item based on a maximum value" do
    price = "1000.50"
    get "/api/v1/items/find?max_price=#{price}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].count).to eq(1)
  end

  it "returns one item when both a min and max value are given" do
    min = "100.50"
    max = "1000.50"
    get "/api/v1/items/find?max_price=#{max}&min_price=#{min}"
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed[:data].count).to eq(1)
  end

  it "return an error if both a name and price range are give"
end
