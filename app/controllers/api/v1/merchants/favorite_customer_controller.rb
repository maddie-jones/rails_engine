class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    merchant = Merchant.find_by(id: params[:id])
    customer = merchant.favorite_customer(merchant)
    render json: CustomerSerializer.new(customer)
  end

end
