require 'rails_helper'

RSpec.describe "Item Search Facade" do
  describe "class methods" do
    describe ".find_item" do
      describe "happy path" do
        it "calls the items.search_by_price method if only a valid minimum price is provided" do
          expect(Item).to receive(:search_by_price)
          Item::SearchFacade.find_item(nil, 5, nil)
        end

        it "calls the items.search_by_price method if only a valid maximum price is provided" do
          expect(Item).to receive(:search_by_price)
          Item::SearchFacade.find_item(nil, nil, 5)
        end

        it "calls the items.search_by_price method if both a valid maximum and minimum price is provided" do
          expect(Item).to receive(:search_by_price)
          Item::SearchFacade.find_item(nil, 4, 5)
        end

        it "calls the items.search_by_name method if valid keyword is provided" do
          expect(Item).to receive(:search_by_name)
          Item::SearchFacade.find_item("string", nil, nil)
        end
      end

      describe "Sad Path" do
        it "calls no methods if minimum is below 0" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, -1, nil)
        end

        it "calls no methods if maximum is below 0" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, nil, -1)
        end

        it "calls no methods if maximum is below 0 and minimum is valid" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, 1, -1)
        end

        it "calls no methods if minimum is below 0 and maximum is valid" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, -1, 1)
        end

        it "calls no methods if minimum is greater then maximum" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, 5, 1)
        end

        it "calls no methods if name is empty string" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item('', nil, nil)
        end

        it "calls no methods if name is and minimun is provided" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item('string', 1, nil)
        end

        it "calls no methods if name is and maximum is provided" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item('string', nil, 5)
        end

        it "calls no methods if no values provided" do
          expect(Item).to_not receive(:search_by_price)
          expect(Item).to_not receive(:search_by_name)
          Item::SearchFacade.find_item(nil, nil, nil)
        end
      end
    end
  end
end
