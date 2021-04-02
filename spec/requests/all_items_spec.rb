require 'rails_helper'

RSpec.describe "all items API end point" do
  before :each do
    100.times do
      create(:item)
    end
  end

  it "returens items equal to the per_page value" do
    per_page = 10
    get "/api/v1/items?per_page=#{per_page}"
    parsed = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(parsed.count).to eq(per_page)
  end

  it "returens 20 items by default" do
    get "/api/v1/items"
    parsed = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(parsed.count).to eq(20)
  end
end
