class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    item = Item.find_by(id: (params[:id]))

    invoice_items = InvoiceItem.where(item_id: "#{item.id}" )

    render json: InvoiceItemSerializer.new(invoice_items)
  end

end
