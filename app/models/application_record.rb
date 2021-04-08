class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.with_offset(offset, per_page)
    offset(offset).limit(per_page)
  end

  def self.search_by_name(name)
    keyword = "%#{name.downcase}%"
    where('lower(name) LIKE ?', keyword)
    .order(:name)
  end
end
