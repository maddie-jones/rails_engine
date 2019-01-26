class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchants = Merchant.by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def index
    num = Merchant.revenue_by_date(params[:date])
    render json: RevenueSerializer.new(Revenue.new(num))
  end


end
