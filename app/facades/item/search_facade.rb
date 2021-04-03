class Item::SearchFacade
  def self.find_item(name, min, max)
    if min || max
      min = 0 unless min
      max = 1000000000000 unless max
      # max = 1 / 0.0 unless max
      Item.where('unit_price > ?', min)
          .where('unit_price < ?', max)
          .order(:name)
          .limit(1)

    elsif name
      keyword = "%#{name.downcase}%"  
    Item.where('lower(name) LIKE ?', keyword).order(:name).limit(1)
    end
  end
end
