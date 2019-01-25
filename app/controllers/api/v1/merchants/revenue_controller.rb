class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchants = Merchant.by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

end
