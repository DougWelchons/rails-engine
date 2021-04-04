require 'rails_helper'

RSpec.describe "Items By Revenue", type: :request do
  before :each do
    seed_test_db
  end

  it "returns the top 10 items by revenue as the default" do
    get "/api/v1/revenue/items?quantity="

    expect(response.status).to eq(200)
    expect(json[:data].count).to eq(10)
  end
end
