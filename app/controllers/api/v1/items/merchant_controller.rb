class Api::V1::Items::MerchantController < ApplicationController

  def show
    item = Item.find_by(id: (params[:id]))

    merchant = Merchant.where(id: "#{item.merchant_id}" )

    render json: MerchantSerializer.new(merchant)
  end

end
