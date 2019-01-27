class Api::V1::Customers::CustomerInvoicesController < ApplicationController

  def index
    customer = Customer.find_by(id: (params[:id]))
    invoices = Invoice.where(customer_id: "#{customer.id}")

    render json: InvoiceSerializer.new(invoices)
  end

end
