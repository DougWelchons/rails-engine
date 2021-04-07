class Merchant::SearchFacade
  extend Validatable

  def self.find_all_merchants(name)
    if valid_param?(name, 0)
      Merchant.search_by_name(name)
    end
  end
end
