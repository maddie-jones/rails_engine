class Api::V1::Invoices::CustomerController < ApplicationController

  def show
    invoice = Invoice.find_by(id: (params[:id]))

    customer = Customer.where(id: "#{invoice.customer_id}" )

    render json: CustomerSerializer.new(customer)
  end

end
