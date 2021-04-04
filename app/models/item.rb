class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.by_revenue(limit)
    limit = 10 unless limit
     joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(limit)
  end
end
