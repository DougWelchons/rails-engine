FactoryBot.define do
  factory :transactions do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { "MyString" }
  end
end
