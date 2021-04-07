require 'rails_helper'

RSpec.describe "Merchants Facade" do
  describe "class methods" do
    describe "by_revenue" do
      it "calls the Merchant.by_revenue method if a valid quantity is provided" do
        expect(Merchant).to receive(:by_revenue)
        MerchantsFacade.by_revenue(5)
      end

      it "does not call the Merchant.by_revenue method if no quantity provided" do
        expect(Merchant).to_not receive(:by_revenue)
        MerchantsFacade.by_revenue(nil)
      end

      it "does not call the Merchant.by_revenue method if the quantity is less then 1" do
        expect(Merchant).to_not receive(:by_revenue)
        MerchantsFacade.by_revenue(0)
      end

      it "does not call the Merchant.by_revenue method if the quantity is blank" do
        expect(Merchant).to_not receive(:by_revenue)
        MerchantsFacade.by_revenue('')
      end

      it "does not call the Merchant.by_revenue method if the quantity is a string" do
        expect(Merchant).to_not receive(:by_revenue)
        MerchantsFacade.by_revenue('string')
      end
    end

    describe "by_items_sold" do
      it "calls the Merchant.by_items_sold method if a valid quantity is provided" do
        expect(Merchant).to receive(:by_items_sold)
        MerchantsFacade.by_items_sold(5)
      end

      it "does not call the Merchant.by_items_sold method if no quantity provided" do
        expect(Merchant).to_not receive(:by_items_sold)
        MerchantsFacade.by_items_sold(nil)
      end

      it "does not call the Merchant.by_items_sold method if the quantity is less then 1" do
        expect(Merchant).to_not receive(:by_items_sold)
        MerchantsFacade.by_items_sold(0)
      end

      it "does not call the Merchant.by_items_sold method if the quantity is blank" do
        expect(Merchant).to_not receive(:by_items_sold)
        MerchantsFacade.by_items_sold('')
      end

      it "does not call the Merchant.by_items_sold method if the quantity is a string" do
        expect(Merchant).to_not receive(:by_items_sold)
        MerchantsFacade.by_items_sold('string')
      end
    end

    describe ".all_merchants" do
      it "when no params are provided it returns offset=0 perpage=20" do
        expect(Merchant).to receive(:with_offset).with(0, 20)
        MerchantsFacade.all_merchants(nil, nil)
      end

      it "when values less the 1 are provided it returns offset=0 perpage=20" do
        expect(Merchant).to receive(:with_offset).with(0, 20)
        MerchantsFacade.all_merchants(-1, -1)
      end

      it "when value of strings are provided it returns offset=0 perpage=20" do
        expect(Merchant).to receive(:with_offset).with(0, 20)
        MerchantsFacade.all_merchants("string", "string")
      end

      it "when value are valid it returns offset=((page_num -1)*per_page) perpage=per_page" do
        expect(Merchant).to receive(:with_offset).with(20, 20)
        MerchantsFacade.all_merchants(2, nil)
      end

      it "when value are valid it returns offset=((page_num -1)*per_page) perpage=per_page" do
        expect(Merchant).to receive(:with_offset).with(90, 30)
        MerchantsFacade.all_merchants(4, 30)
      end
    end
  end
end
