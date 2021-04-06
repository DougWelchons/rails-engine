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

    describe ".search_by_price" do
      it "returns one item between the min and max value" do
        expect(Item.search_by_price(15, 50)[0].name).to eq("another item")
      end

      it "returns an empty array if no items are between the min and max value" do
        expect(Item.search_by_price(150, 500).length).to eq(0)
      end
    end

    describe ".search_by_name" do
      it "returns one item matching the search result" do
        expect(Item.search_by_name("%thing%")[0].name).to eq("item-that-does things")
      end

      it "returns an empty array if no items thew search keyword" do
        expect(Item.search_by_name("nothing").length).to eq(0)
      end
    end

    describe ".by_revenue" do
      it "returns 10 items by default sorted by revenue" do
        items = Item.by_revenue(nil, "items")
        expect(items.length).to eq(10)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("more item")
        expect(items[3].name).to eq("Item 7")
        expect(items[4].name).to eq("Item 8")
        expect(items[5].name).to eq("Item 17")
        expect(items[6].name).to eq("Item 10")
        expect(items[7].name).to eq("Item 12")
        expect(items[8].name).to eq("stuff-n-things")
        expect(items[9].name).to eq("Item 16")
      end

      it "if a limit is provided, it will return items equal to the limit" do
        limit = 4
        items = Item.by_revenue(limit, "items")
        expect(items.length).to eq(limit)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("more item")
        expect(items[3].name).to eq("Item 7")
      end

      it "returns all items with successful transactions if limit is greater than the number of results" do
        limit = 50
        items = Item.by_revenue(limit, "items")
        expect(items.length).to eq(11)
        expect(items[0].name).to eq("Item 11")
        expect(items[1].name).to eq("Item 18")
        expect(items[2].name).to eq("more item")
        expect(items[3].name).to eq("Item 7")
        expect(items[4].name).to eq("Item 8")
        expect(items[5].name).to eq("Item 17")
        expect(items[6].name).to eq("Item 10")
        expect(items[7].name).to eq("Item 12")
        expect(items[8].name).to eq("stuff-n-things")
        expect(items[9].name).to eq("Item 16")
        expect(items[10].name).to eq("Item 19")
      end
    end

    describe ".with_offset" do
      it "returns the number of items with offset" do
        offset = 5
        per_page = 2
        items = Item.with_offset(offset, per_page)

        expect(items.count).to eq(2)
        expect(items.first.name).to eq("item-that-does things")
        expect(items.second.name).to eq("Item 7")
      end
    end
  end
end
