class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant::SearchFacade.find_all_merchants(params[:name])
    render json: MerchantSerializer.new(merchants)
  end
end
