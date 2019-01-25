class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchants = Merchant.by_revenue(num)
    render json: MerchantSerializer.new(merchants)
  end

end
