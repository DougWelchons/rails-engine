require 'rails_helper'

RSpec.describe "merchants find_all API end point", type: :request do
  before :each do
    seed_test_db
  end

  describe "Happy Path" do
    it "returns all merchants who match the name search perams" do
      name = "the"
      get "/api/v1/merchants/find_all?name=#{name}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(5)
      expect(json[:data]).to be_an(Array)
    end

    it "returns no objects if no merchants match the name search params" do
      name = "No Match"
      get "/api/v1/merchants/find_all?name=#{name}"

      expect(response.status).to eq(200)
      expect(json[:data].count).to eq(0)
      expect(json[:data]).to be_an(Array)
    end
  end

  describe "Sad Path" do
    it "returns a 400 response if the name search params is not provided" do
      get "/api/v1/merchants/find_all"

      expect(response.status).to eq(400)
    end

    it "returns a 400 response if the name search params is blank" do
      get "/api/v1/merchants/find_all?name="

      expect(response.status).to eq(400)
    end
  end
end
