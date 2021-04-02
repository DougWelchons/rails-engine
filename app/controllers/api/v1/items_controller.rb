class Api::V1::ItemsController < ApplicationController

  def index
    items = ItemsFacade.all_items(params[:per_page], params[:page])

    render json: ItemSerializer.new(items)
  end
end
