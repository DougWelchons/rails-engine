require 'rails_helper'

RSpec.describe "Merchants Search Facade" do
  describe "class methods" do
    describe "find_all_merchants" do
      it "calls the merchants.search_by_name method if a valid string is provided" do
        expect(Merchant).to receive(:search_by_name)
        Merchant::SearchFacade.find_all_merchants("thing")
      end

      it "does not call the merchants.search_by_name method if no string provided" do
        expect(Merchant).to_not receive(:search_by_name)
        Merchant::SearchFacade.find_all_merchants(nil)
      end

      it "does not call the merchants.search_by_name method if no string is empty" do
        expect(Merchant).to_not receive(:search_by_name)
        Merchant::SearchFacade.find_all_merchants("")
      end
    end
  end
end
