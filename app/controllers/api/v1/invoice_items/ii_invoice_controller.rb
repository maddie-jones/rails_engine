class Api::V1::InvoiceItems::IiInvoiceController < ApplicationController

  def show
    invoice_item = InvoiceItem.find_by(id: (params[:id]))
    invoice = invoice_item.by_invoice(invoice_item)

    render json: InvoiceSerializer.new(invoice)
  end

end
