class Api::V1::InvoicesController < ApplicationController

  def unshipped_revenue
    if valid_param?(params[:quantity]) || !params[:quantity]
      invoices = Invoice.unshiped_potential_revenue(params[:quantity])

      render json: UnshippedOrderSerializer.new(invoices)
    else
      render json: {error: {}}, status: :bad_request
    end
  end

  def valid_param?(param)
    return true if (param && param !="") && param.to_i >= 1
    false
  end
end
