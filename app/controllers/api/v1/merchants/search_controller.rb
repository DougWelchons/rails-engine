class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant::SearchFacade.find_all_merchants(params[:name])
    return error("Invalid search. Please check you search params") unless merchants
    render json: MerchantSerializer.new(merchants)
  end
end
