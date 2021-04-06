require 'json'

class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.all_merchants(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  def by_revenue
    merchants = MerchantsFacade.by_revenue(params[:quantity])
    return render json: {error: {}}, status: :bad_request unless merchants
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def by_items
    merchants = MerchantsFacade.by_items_sold(params[:quantity])
    return render json: {error: {}}, status: :bad_request unless merchants
    render json: MerchantNameItemsSerializer.new(merchants)
  end
end
