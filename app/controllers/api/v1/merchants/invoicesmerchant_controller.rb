class Api::V1::Merchants::InvoicesmerchantController < ApplicationController

  def index
    merchant = Merchant.find_by(id: (params[:id]))
    invoices = Invoice.where(merchant_id: "#{merchant.id}")

    render json: InvoiceSerializer.new(invoices)
  end

end
