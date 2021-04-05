class Api::V1::Items::SearchController < ApplicationController

  def show
    if params[:name] && (params[:min_price] || params[:max_price])
      render json: @item, status: :bad_request
    elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
      render json: {error: {}}, status: :bad_request
    else
      item = Item::SearchFacade.find_item(params[:name], params[:min_price], params[:max_price])
      if item == []
        render json:{data: {}}
      else
        render json: ItemSerializer.new(item.first)
      end
    end
  end

  def valid_param?(param)
    return true if (param && param !="") && param.to_i >= 1
    false
  end
end
