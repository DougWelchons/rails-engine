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
end
