class Item::SearchFacade
  extend Validatable

  def self.find_item(name, min, max)
    if valid_search_params?(name, min, max)
      if min || max
        min = 0 unless min
        max = 1000000000000 unless max
        # max = 1 / 0.0 unless max
        Item.search_by_price(min, max)

      elsif name
        Item.search_by_name(name)
      end
    end
  end
end
