FactoryBot.define do
  factory :transactions do
    invoice { nil }
    credit_card_number { "CC number" }
    credit_card_expiration_date { "experation date" }
    result { "" }
  end
end
