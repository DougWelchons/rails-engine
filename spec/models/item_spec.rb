require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe "class methods" do
    before :each do
      seed_test_db
    end
    describe ".by_revenue" do
      it "returns 10 items by default sorted by revenue" do
        items = Item.by_revenue(nil)
        expect(items.length).to eq(10)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("Item 5")
        expect(items[3].name).to eq("Item 7")
        expect(items[4].name).to eq("Item 8")
        expect(items[5].name).to eq("Item 17")
        expect(items[6].name).to eq("Item 10")
        expect(items[7].name).to eq("Item 12")
        expect(items[8].name).to eq("Item 4")
        expect(items[9].name).to eq("Item 16")
      end

      it "if a limit is provided, it will return items equal to the limit" do
        limit = 4
        items = Item.by_revenue(limit)
        expect(items.length).to eq(limit)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("Item 5")
        expect(items[3].name).to eq("Item 7")
      end

      it "returns all items with successful transactions if limit is greater than the number of results" do
        limit = 50
        items = Item.by_revenue(limit)
        expect(items.length).to eq(11)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("Item 5")
        expect(items[3].name).to eq("Item 7")
        expect(items[4].name).to eq("Item 8")
        expect(items[5].name).to eq("Item 17")
        expect(items[6].name).to eq("Item 10")
        expect(items[7].name).to eq("Item 12")
        expect(items[8].name).to eq("Item 4")
        expect(items[9].name).to eq("Item 16")
        expect(items[10].name).to eq("Item 19")
      end
    end
  end
end
