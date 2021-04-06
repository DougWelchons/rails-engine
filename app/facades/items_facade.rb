class ItemsFacade
  extend Validatable

  def self.all_items(per_page, page)
    page = 1 unless valid_param?(page)
    per_page = 20 unless valid_param?(per_page)
    offset = ((page.to_i - 1) * per_page.to_i)

    Item.offset(offset).limit(per_page)
  end

  def self.by_revenue(limit)
    Item.by_revenue(limit, "items") if valid_optional_param?(limit)
  end
end
