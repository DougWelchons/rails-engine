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
      it "it will return merchants equal to the limit" do
        limit = 2
        merchants = Merchant.by_revenue(limit)

        expect(merchants.length).to eq(limit)
        expect(merchants[0].name).to eq("stand by")
        expect(merchants[1].name).to eq("try again")
      end

      it "returns all merchants with successful transactions if limit is greater than the number of results" do
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

    describe ".by_items_sold" do
      it "it will return merchants equal to the limit" do
        limit = 2
        merchants = Merchant.by_items_sold(limit)

        expect(merchants.length).to eq(limit)
        expect(merchants[0].name).to eq("try again")
        expect(merchants[1].name).to eq("one more")
      end

      it "returns all merchants with successful transactions if limit is greater than the number of results" do
        limit = 50
        merchants = Merchant.by_items_sold(limit)

        expect(merchants.length).to eq(6)
        expect(merchants[0].name).to eq("try again")
        expect(merchants[1].name).to eq("one more")
        expect(merchants[2].name).to eq("stand by")
        expect(merchants[3].name).to eq("the merchants guild")
        expect(merchants[4].name).to eq("the merchants for all")
        expect(merchants[5].name).to eq("Merchants 4 me")
      end
    end

    describe ".search_by_name" do
      it "it will return all merchants that match the keyword" do
        keyword = "thing"
        merchants = Merchant.search_by_name(keyword)

        expect(merchants.length).to eq(2)
        expect(merchants[0].name).to eq("Merchants that do the thing")
        expect(merchants[1].name).to eq("this other thing")
      end

      it "returns no objects if no merchants mach the keyword" do
        keyword = "No Match"
        merchants = Merchant.search_by_name(keyword)

        expect(merchants.length).to eq(0)
      end
    end

    describe ".with_offset" do
      it "returns the number of merchants with offset" do
        offset = 5
        per_page = 2
        merchants = Merchant.with_offset(offset, per_page)

        expect(merchants.count).to eq(2)
        expect(merchants.first.name).to eq("the merchants for all")
        expect(merchants.second.name).to eq("the merchants guild")
      end
    end
  end
end
