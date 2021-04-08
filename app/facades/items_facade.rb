class ItemsFacade
  extend Validatable

  def self.all_items(page, per_page)
    page = 1 unless valid_param?(page)
    per_page = 20 unless valid_param?(per_page)
    offset = ((page.to_i - 1) * per_page.to_i)

    Item.with_offset(offset, per_page)
  end

  def self.by_revenue(limit)
    Item.by_revenue(limit) if valid_optional_param?(limit)
  end
end
