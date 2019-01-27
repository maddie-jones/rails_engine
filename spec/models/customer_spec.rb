require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '.all_transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)
    transaction_1 = create(:transaction, invoice: invoice_1, result: "success")
    transaction_2 = create(:transaction, invoice: invoice_2, result: "success")
    transaction_3 = create(:transaction, invoice: invoice_3, result: "success")

    expect(customer.all_transactions(customer)).to eq([transaction_1, transaction_2, transaction_3])
  end
end
