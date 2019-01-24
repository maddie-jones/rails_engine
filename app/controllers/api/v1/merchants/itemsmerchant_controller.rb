class Api::V1::Merchants::ItemsmerchantController < ApplicationController

  def index
    merchant = Merchant.find_by(id: (params[:id]))
    items = Item.where(merchant_id: "#{merchant.id}")

    render json: ItemSerializer.new(items)
  end

end
