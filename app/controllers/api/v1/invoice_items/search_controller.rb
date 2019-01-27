class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))

  end

private

  def invoice_item_params
    if params.include?(:unit_price)
      ip = params.permit(:unit_price)
      {unit_price: ip[:unit_price].gsub(".","")}
    else
      params.permit(:id, :invoice_id, :item_id, :quantity, :created_at, :updated_at)
    end
  end

end
