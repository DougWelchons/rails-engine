require 'rails_helper'

RSpec.describe "Unshiped Revenue", type: :request do
  before :each do
    seed_test_db
  end

  it "returns the top ten unshiped invoces ranked by ravenue by default" do
    get "/api/v1/revenue/unshipped"

    expect(response.status).to eq(200)
    expect(json[:data].count).to eq(10)
  end
end
