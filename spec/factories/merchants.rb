FactoryBot.define do
  factory :merchant do
    sequence :id do |n|
      "#{n}"
    end

    sequence :name do |n|
      "Merchant#{n}"
    end
  end
end
