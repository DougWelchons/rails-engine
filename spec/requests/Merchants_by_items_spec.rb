require 'rails_helper'

RSpec.describe "merchants by items sold", type: :request do
  before :each do
    seed_test_db
  end

  it "returnd the top merchants by number of items sold" do
    get "/api/v1/merchants/most_items?quantity=2"

    expect(response.status).to eq(200)
  end
end
