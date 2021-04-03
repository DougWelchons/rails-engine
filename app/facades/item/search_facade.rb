class Item::SearchFacade
  def self.find_item(name, min, max)
    if min || max
      min = 0 unless min
      max = 1000000000 unless max
      item = Item.where('unit_price > ?', "#{min}")
                 .where('unit_price < ?', "#{max}")
                 .limit(1)
    elsif name
      keyword = "%#{name}%"
      item = Item.where('name LIKE ?', keyword).limit(1)
    end
  end
end
