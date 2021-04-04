FactoryBot.define do
  factory :transaction do
    credit_card_number { "CC number" }
    credit_card_expiration_date { "experation date" }
    result { "success" }
    invoice
  end
end
