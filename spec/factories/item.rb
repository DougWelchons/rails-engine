FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "Item#{n}"
    end

    sequence :description do |n|
      "Desription#{n}"
    end

    sequence :unit_price do |n|
      "#{n}.99"
    end

    merchant
  end
end
