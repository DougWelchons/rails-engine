require 'rails_helper'

RSpec.describe "merchants find_all API end point", type: :request do
  before :each do
    seed_test_db
  end

  it "returns all merchants who match the search peramiters" do
    name = "the"
    get "/api/v1/merchants/find_all?name=#{name}"

    expect(response.status).to eq(200)
    expect(json[:data].count).to eq(5)
    expect(json[:data]).to be_an(Array)
  end
end
