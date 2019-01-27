class Api::V1::Customers::SearchController < ApplicationController

  def show
    customer = Customer.find_by(customer_params)
    render json: CustomerSerializer.new(customer)
  end

  def index
    customers = Customer.where(customer_params)
    render json: CustomerSerializer.new(customers)
  end

  private

  def customer_params
    params.permit(:id, :fist_name, :last_name)
  end

end
