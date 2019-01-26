class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    invoice = Invoice.find_by(id: (params[:id]))
    
    merchant = Merchant.where(id: "#{invoice.merchant_id}" )

    render json: MerchantSerializer.new(merchant)
  end

end
