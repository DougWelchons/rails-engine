class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.by_revenue(limit, object)
    limit = 10 unless limit
     joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select("#{object}.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order(revenue: :desc)
    .limit(limit)
  end

  def self.with_offset(offset, per_page)
    offset(offset).limit(per_page)
  end

  def self.search_by_name(name)
    keyword = "%#{name.downcase}%"
    where('lower(name) LIKE ?', keyword)
    .order(:name)
  end
end
