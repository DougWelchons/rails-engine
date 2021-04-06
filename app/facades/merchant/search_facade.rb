class Merchant::SearchFacade

  def self.find_all_merchants(name)
    if name && name != ''
      keyword = "%#{name.downcase}%"
      Merchant.where('lower(name) LIKE ?', keyword)
    end
  end
end
