require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:items) }
  end
  #
  # describe "validations" do
  #   it { should validate_presence_of :quantity }
  #   it { should validate_numericality_of :quantity }
  #   it { should validate_presence_of :unit_price }
  #   it { should validate_numericality_of :unit_price }
  # end
end
