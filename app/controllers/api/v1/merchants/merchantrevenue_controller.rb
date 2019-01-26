class Api::V1::Merchants::MerchantrevenueController < ApplicationController

  def show
    merchant = Merchant.find_by(id: params[:id])

    num = merchant.total_revenue

    render json: RevenueSerializer.new(Revenue.new(num))
  end

  def index
    merchant = Merchant.find_by(id: params[:id])

    num = merchant.revenue_by_date(params[:date])
    render json: RevenueSerializer.new(num)
  end

end
