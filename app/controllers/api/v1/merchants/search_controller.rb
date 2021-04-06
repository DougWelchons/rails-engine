class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant::SearchFacade.find_all_merchants(params[:name])
    return render json: {error: {}}, status: :bad_request unless merchants
    render json: MerchantSerializer.new(merchants)
  end
end
