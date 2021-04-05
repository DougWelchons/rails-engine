class Api::V1::ItemsController < ApplicationController

  def index
    items = ItemsFacade.all_items(params[:per_page], params[:page])
    render json: ItemSerializer.new(items)
  end

  def by_revenue
    items = ItemsFacade.by_revenue(params[:quantity])
    return render json: {error: {}}, status: :bad_request unless items
    render json: ItemRevenueSerializer.new(items)
  end
end
