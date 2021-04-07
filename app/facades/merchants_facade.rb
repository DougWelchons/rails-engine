class MerchantsFacade
  extend Validatable

  def self.all_merchants(page, per_page)
    page = 1 unless valid_param?(page)
    per_page = 20 unless valid_param?(per_page)
    offset = ((page.to_i - 1) * per_page.to_i)

    Merchant.with_offset(offset, per_page)
  end

  def self.by_revenue(limit)
      Merchant.by_revenue(limit, "merchants") if valid_param?(limit)
  end

  def self.by_items_sold(limit)
      Merchant.by_items_sold(limit) if valid_param?(limit)
  end
end
