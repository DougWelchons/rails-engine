class Api::V1::ItemsController < ApplicationController

  def index
    items = ItemsFacade.all_items(params[:per_page], params[:page])

    render json: ItemSerializer.new(items)
  end

  def by_revenue
    if ItemsFacade.valid_param?(params[:quantity]) || !params[:quantity]
      items = ItemsFacade.by_revenue(params[:quantity])
      render json: ItemRevenueSerializer.new(items)
    else
      render json: {error: {}}, status: :bad_request
    end
  end
end
