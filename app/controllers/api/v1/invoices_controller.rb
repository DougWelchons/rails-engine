class Api::V1::InvoicesController < ApplicationController

  def unshipped_revenue
    invoices = Invoice.unshiped_potential_revenue(params[:quantity])

    render json: UnshippedOrderSerializer.new(invoices)
  end
end
