class Item::SearchFacade
  def self.find_item(name, min, max)
    if valid_search?(name, min, max)
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

  def self.valid_param?(param)
    return true if (param && param !='') && param.to_f >= 0
    false
  end
end

def valid_search?(name, min, max)
  return false if name && (min || max)
  return false if max && min.to_f > max.to_f
  return true if valid_param?(name) || valid_param?(min) || valid_param?(max)
end
