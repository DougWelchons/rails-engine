class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.unshiped_potential_revenue(limit)
    limit = 10 unless limit
     joins(:invoice_items)
    .where('invoices.status = ?', 'packaged')
    .select('invoices.id, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
    .order(potential_revenue: :desc)
    .group(:id)
    .limit(limit)
  end
end
