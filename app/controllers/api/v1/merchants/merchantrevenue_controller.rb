class Api::V1::Merchants::MerchantrevenueController < ApplicationController

  def show
    merchants = Merchant.by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def index
    revenue = Merchant.revenue_by_date(params[:quantity])
    render json: MerchantSerializer.new(revenue)
  end

end
