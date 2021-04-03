class Api::V1::Items::SearchController < ApplicationController

  def show
    if params[:name] && (params[:min_price] || params[:max_price])
      error = 401
    else
      item = Item::SearchFacade.find_item(params[:name], params[:min_price], params[:max_price])

      render json: ItemSerializer.new(item)
    end
  end
end
