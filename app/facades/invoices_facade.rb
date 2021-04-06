class InvoicesFacade

  def self.unshipped_revenue(limit)
    if self.valid_param?(limit) || !limit
     Invoice.unshipped_potential_revenue(limit)
    end
  end

  def self.valid_param?(param)
    return true if (param && param !="") && param.to_i >= 1
    false
  end
end
