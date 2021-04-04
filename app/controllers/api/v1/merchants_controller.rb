require 'json'

class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.all_merchants(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def by_revenue
    merchants = MerchantsFacade.by_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def by_items
    if params[:quantity]
      merchants = Merchant.merchants_by_items_sold(params[:quantity])
      render json: MerchantNameItemsSerializer.new(merchants)
    else
      render json: {error: {}}, status: 400
    end
  end
end
