FactoryBot.define do
  factory :invoice_items do
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price { "9.99" }
    invoice
    item
  end
end
