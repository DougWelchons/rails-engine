require 'json'

class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.all_merchants(params[:page], params[:per_page])
    render json: MerchantSerializer.new(merchants)
  end

  def by_revenue
    merchants = MerchantsFacade.by_revenue(params[:quantity])
    return error("quantity must be greater then 0") unless merchants
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def by_items
    merchants = MerchantsFacade.by_items_sold(params[:quantity])
    return error("quantity must be greater then 0") unless merchants
    render json: MerchantNameItemsSerializer.new(merchants)
  end
end
