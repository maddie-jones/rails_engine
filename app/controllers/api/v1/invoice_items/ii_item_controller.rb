class Api::V1::InvoiceItems::IiItemController < ApplicationController

  def show
    invoice_item = InvoiceItem.find_by(id: (params[:id]))
    item = invoice_item.by_item(invoice_item)

    render json: ItemSerializer.new(item)
  end

end
