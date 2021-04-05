class ItemsFacade

  def self.all_items(per_page, page)
    page = 1 unless valid_param?(page)
    per_page = 20 unless valid_param?(per_page)
    offset = ((page.to_i - 1) * per_page.to_i)

    Item.offset(offset).limit(per_page)
  end

  def self.by_revenue(limit)
    if self.valid_param?(limit) || !limit
      Item.by_revenue(limit, "items")
    end
  end

  def self.valid_param?(param)
    return true if (param && param !="") && param.to_i >= 1
    false
  end
end
