FactoryBot.define do
  factory :invoices do
    customer { "" }
    merchant { nil }
    status { "MyString" }
  end
end
