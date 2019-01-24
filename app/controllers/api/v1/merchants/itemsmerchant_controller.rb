class Api::V1::Merchants::ItemsmerchantController < ApplicationController

  def index
    merchant = Merchant.find_by(id: (params[:id]))
    items = merchant.all_items

    render json: MerchantSerializer.new(merchant)
  end

end
