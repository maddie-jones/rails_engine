class Api::V1::Merchants::SearchController < ApplicationController

  def show
    merchant = Merchant.find_by(name: (params[:name]))
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where(name: (params[:name]))
    render json: MerchantSerializer.new(merchants)
  end

end
