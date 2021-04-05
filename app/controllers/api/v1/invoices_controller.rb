class Api::V1::InvoicesController < ApplicationController

  def unshipped_revenue
    invoices = InvoicesFacade.unshipped_revenue(params[:quantity])
    return render json: {error: {}}, status: :bad_request unless invoices
    render json: UnshippedOrderSerializer.new(invoices)
  end
end
