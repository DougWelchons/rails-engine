FactoryBot.define do
  factory :invoices do
    status { "shipped packaged returned" }
    customer
    merchant
  end
end
