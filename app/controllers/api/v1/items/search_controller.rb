class Api::V1::Items::SearchController < ApplicationController

  def show
    item = Item::SearchFacade.find_item(params[:name], params[:min_price], params[:max_price])
    return render json: {error: {}}, status: :bad_request unless item
    return render json:{data: {}} if item == []
    render json: ItemSerializer.new(item.first)
  end
end
