class Api::V1::Items::SearchController < ApplicationController

  def show
    item = Item::SearchFacade.find_item(params[:name], params[:min_price], params[:max_price])
    return error("Invalid search. Please check you search params") unless item
    return render json:{data: {}} if item == []
    render json: ItemSerializer.new(item.first)
  end
end
