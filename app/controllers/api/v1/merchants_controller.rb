require 'json'

class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.all_merchants(params[:per_page], params[:page])

    merchant_hash = render json: merchants
  end
end
