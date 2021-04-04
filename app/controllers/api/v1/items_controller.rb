class Api::V1::ItemsController < ApplicationController

  def index
    items = ItemsFacade.all_items(params[:per_page], params[:page])

    render json: ItemSerializer.new(items)
  end

  def by_revenue
    item = Item.by_revenue(params[:quantity])

    render json: ItemRevenueSerializer.new(item)
  end
end
