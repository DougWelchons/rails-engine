require 'json'

class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.all_merchants(params[:per_page], params[:page])

    render json: MerchantSerializer.new(merchants)
  end
end
