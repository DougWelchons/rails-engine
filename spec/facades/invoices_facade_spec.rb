require 'rails_helper'

RSpec.describe "Invoices Facade" do
  describe "class methods" do
    describe "unshipped_revenue" do
      it "calls the invoice.unshipped_potential_revenue method if no quantity provided" do
        expect(Invoice).to receive(:unshipped_potential_revenue)
        InvoicesFacade.unshipped_revenue(nil)
      end

      it "calls the invoice.unshipped_potential_revenue method if valid quanitiy is provided" do
        expect(Invoice).to receive(:unshipped_potential_revenue)
        InvoicesFacade.unshipped_revenue(5)
      end

      it "does not call the invoice.unshipped_potential_revenue method if quanity is less then 1" do
        expect(Invoice).to_not receive(:unshipped_potential_revenue)
        InvoicesFacade.unshipped_revenue(0)
      end

      it "does not call the invoice.unshipped_potential_revenue method if quanity is blank" do
        expect(Invoice).to_not receive(:unshipped_potential_revenue)
        InvoicesFacade.unshipped_revenue("")
      end

      it "does not call the invoice.unshipped_potential_revenue method if quanity is a string" do
        expect(Invoice).to_not receive(:unshipped_potential_revenue)
        InvoicesFacade.unshipped_revenue("string")
      end
    end
  end
end
