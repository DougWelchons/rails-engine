class MerchantsFacade

  def self.all_merchants(per_page, page)
    page = 1 unless page
    per_page = 20 unless per_page
    
    Merchant.all.limit(per_page)
  end
end
