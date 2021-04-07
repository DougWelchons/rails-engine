require 'rails_helper'

RSpec.describe "Items Facade" do
  describe "class methods" do
    describe "by_revenue" do
      it "calls the Item.by_revenue method if no quantity provided" do
        expect(Item).to receive(:by_revenue)
        ItemsFacade.by_revenue(nil)
      end

      it "calls the Item.by_revenue method if a valid quantity is provided" do
        expect(Item).to receive(:by_revenue)
        ItemsFacade.by_revenue(5)
      end

      it "does not call the Item.by_revenue method if the quantity is less then 1" do
        expect(Item).to_not receive(:by_revenue)
        ItemsFacade.by_revenue(0)
      end

      it "does not call the Item.by_revenue method if the quantity is blank" do
        expect(Item).to_not receive(:by_revenue)
        ItemsFacade.by_revenue('')
      end

      it "does not call the Item.by_revenue method if the quantity is a string" do
        expect(Item).to_not receive(:by_revenue)
        ItemsFacade.by_revenue('string')
      end
    end

    describe ".all_items" do
      it "when no params are provided it returns offset=0 perpage=20" do
        expect(Item).to receive(:with_offset).with(0, 20)
        ItemsFacade.all_items(nil, nil)
      end

      it "when values less the 1 are provided it returns offset=0 perpage=20" do
        expect(Item).to receive(:with_offset).with(0, 20)
        ItemsFacade.all_items(-1, -1)
      end

      it "when value of strings are provided it returns offset=0 perpage=20" do
        expect(Item).to receive(:with_offset).with(0, 20)
        ItemsFacade.all_items("string", "string")
      end

      it "when value are valid it returns offset=((page_num -1)*per_page) perpage=per_page" do
        expect(Item).to receive(:with_offset).with(20, 20)
        ItemsFacade.all_items(2, nil)
      end

      it "when value are valid it returns offset=((page_num -1)*per_page) perpage=per_page" do
        expect(Item).to receive(:with_offset).with(90, 30)
        ItemsFacade.all_items(4, 30)
      end
    end
  end
end
