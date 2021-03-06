class Api::V1::ItemsController < ApplicationController

  def index
    items = ItemsFacade.all_items(params[:page], params[:per_page])
    render json: ItemSerializer.new(items)
  end

  def by_revenue
    items = ItemsFacade.by_revenue(params[:quantity])
    return error("quantity must be greater then 0") unless items
    render json: ItemRevenueSerializer.new(items)
  end
end
