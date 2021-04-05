class MerchantsFacade

  def self.all_merchants(per_page, page)
    page = 1 unless valid_param?(page)
    per_page = 20 unless valid_param?(per_page)
    offset = ((page.to_i - 1) * per_page.to_i)

    Merchant.offset(offset).limit(per_page)
  end

  def self.by_revenue(limit)
      Merchant.by_revenue(limit, "merchants") if self.valid_param?(limit)
  end

  def self.by_items_sold(limit)
      Merchant.by_items_sold(limit) if self.valid_param?(limit)
  end

  def self.valid_param?(param)
    return true if (param && param !="") && param.to_i >= 1
    false
  end

end
