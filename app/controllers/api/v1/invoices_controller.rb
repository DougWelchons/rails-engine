class Api::V1::InvoicesController < ApplicationController

  def unshipped_revenue
    invoices = InvoicesFacade.unshipped_revenue(params[:quantity])
    return error("quantity must be greater then 0") unless invoices
    render json: UnshippedOrderSerializer.new(invoices)
  end
end
