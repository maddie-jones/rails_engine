class Api::V1::Customers::CustomerTransactionsController < ApplicationController

  def index
    customer = Customer.find_by(id: (params[:id]))
    transactions = customer.all_transactions(customer)

    render json: TransactionSerializer.new(transactions)
  end

end
