class Merchant::V1::Api < ApplicationRecord
  has_many :items, dependant: :destroy
end
