require 'rails_helper'

RSpec.describe "merchants by revenue", type: :request do
  before :each do
    seed_test_db
  end

  it "returnd the top merchants by revenue" do
    get "/api/v1/revenue/merchants?quantity=15"

    expect(response.status).to eq(200)
  end
end
