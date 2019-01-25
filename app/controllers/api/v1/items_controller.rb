class Api::V1::ItemssController < ApplicationController

  def index
     render json: ItemsSerializer.new(Item.all)
  end

  def show
    render json: ItemsSerializer.new(Item.find(params[:id]))
  end

end
