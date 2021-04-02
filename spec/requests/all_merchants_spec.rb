require 'rails_helper'

RSpec.describe "all merchants API end point" do
  it "returens all merchants whe the end point is hit" do
    100.times do
      create(:merchant)
    end

    get '/api/v1/merchants?per_page=10'
    parsed = JSON.parse(response.body)
    require "pry"; binding.pry

    expect(response.status).to eq(200)
  end
end
