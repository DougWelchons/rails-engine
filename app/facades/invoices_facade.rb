class InvoicesFacade
  extend Validatable

  def self.unshipped_revenue(limit)
    Invoice.unshipped_potential_revenue(limit) if valid_optional_param?(limit)
  end
end
