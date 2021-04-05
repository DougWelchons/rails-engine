require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:items) }
  end

  describe "class methods" do
    before :each do
      seed_test_db
    end
    describe ".by_revenue" do
      it "it will return merchants eqqual to the limit" do
        limit = 2
        merchants = Merchant.by_revenue(limit)

        expect(merchants.length).to eq(limit)
        expect(merchants[0].name).to eq("stand by")
        expect(merchants[1].name).to eq("try again")
      end

      it "returns all merchants with successful transactions if limit is greater than the numbewr of results" do
        limit = 50
        merchants = Merchant.by_revenue(limit)

        expect(merchants.length).to eq(6)
        expect(merchants[0].name).to eq("stand by")
        expect(merchants[1].name).to eq("try again")
        expect(merchants[2].name).to eq("Merchants 4 me")
        expect(merchants[3].name).to eq("the merchants for all")
        expect(merchants[4].name).to eq("the merchants guild")
        expect(merchants[5].name).to eq("one more")
      end
    end
  end
end
