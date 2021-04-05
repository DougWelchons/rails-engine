require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe "class methods" do
    before :each do
      seed_test_db
    end
    describe ".unshiped_potential_revenue" do
      it "it will return 10 invoices by default" do
        limit = nil
        invoices = Invoice.unshiped_potential_revenue(limit)
        expect(invoices.length).to eq(10)
        expect(invoices[0].potential_revenue).to eq(20770.0)
        expect(invoices[1].potential_revenue).to eq(4451.0)
        expect(invoices[2].potential_revenue).to eq(2025.0)
        expect(invoices[3].potential_revenue).to eq(1891.0)
        expect(invoices[4].potential_revenue).to eq(1500.0)
        expect(invoices[5].potential_revenue).to eq(1069.75)
        expect(invoices[6].potential_revenue).to eq(1000.0)
        expect(invoices[7].potential_revenue).to eq(385.5)
        expect(invoices[8].potential_revenue).to eq(169.29)
        expect(invoices[9].potential_revenue).to eq(120.0)
      end

      it "if a limit is provided, it will return invoices equal to the limit" do
        limit = 2
        invoices = Invoice.unshiped_potential_revenue(limit)

        expect(invoices.length).to eq(limit)
        expect(invoices[0].potential_revenue).to eq(20770.0)
        expect(invoices[1].potential_revenue).to eq(4451.0)
      end

      it "returns all invoices that have not shipped if limit is greater than the number of results" do
        limit = 50
        invoices = Invoice.unshiped_potential_revenue(limit)

        expect(invoices.length).to eq(11)
        expect(invoices[0].potential_revenue).to eq(20770.0)
        expect(invoices[1].potential_revenue).to eq(4451.0)
        expect(invoices[2].potential_revenue).to eq(2025.0)
        expect(invoices[3].potential_revenue).to eq(1891.0)
        expect(invoices[4].potential_revenue).to eq(1500.0)
        expect(invoices[5].potential_revenue).to eq(1069.75)
        expect(invoices[6].potential_revenue).to eq(1000.0)
        expect(invoices[7].potential_revenue).to eq(385.5)
        expect(invoices[8].potential_revenue).to eq(169.29)
        expect(invoices[9].potential_revenue).to eq(120.0)
        expect(invoices[10].potential_revenue).to eq(101.0)
      end
    end
  end
end
