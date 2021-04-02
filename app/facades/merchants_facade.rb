class MerchantsFacade

  def self.all_merchants(per_page, page)
    page = 1 unless page
    per_page = 20 unless per_page
    offset = ((page.to_i - 1) * per_page.to_i)

    Merchant.offset(offset).limit(per_page)
  end
end
