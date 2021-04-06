class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # def self.by_revenue(limit)
  #   limit = 10 unless limit
  #    joins(:transactions)
  #   .where('transactions.result = ?', 'success')
  #   .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
  #   .group(:id)
  #   .order(revenue: :desc)
  #   .limit(limit)
  # end

  def self.search_by_price(min, max)
     where('unit_price > ?', min)
    .where('unit_price < ?', max)
    .order(:name)
    .limit(1)
  end

  def self.search_by_name(name)
     where('lower(name) LIKE ?', name)
    .order(:name)
    .limit(1)
  end

  def self.with_offset(offset, per_page)
    offset(offset).limit(per_page)
  end
end
