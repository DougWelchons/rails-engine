class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.by_revenue(limit)
     joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select('merchants.id, merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(limit)
  end

  def self.merchants_by_items_sold(limit = 5)
     joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select('merchants.id, merchants.name, sum(invoice_items.quantity) AS item_count')
    .group(:id)
    .order(item_count: :desc)
    .limit(limit)
  end
end
