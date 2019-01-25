require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "#all_items" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    expect(merchant.all_items).to eq([item_1, item_2, item_3])
  end

  it ".by_revenue" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 4, unit_price: 600 )
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 3, unit_price: 245 )
    transaction_1 = create(:transaction, invoice: invoice_1, result: "success")

    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
    item_3 = create(:item, merchant: merchant_2)
    invoice_item_1 = create(:invoice_item, item: item_3, invoice: invoice_2, quantity: 10 , unit_price: 1000)
    transaction_2 = create(:transaction, invoice: invoice_2, result: "success")

    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_4 = create(:item, merchant: merchant_3)
    item_5 = create(:item, merchant: merchant_3)
    invoice_3 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_4, invoice: invoice_3, quantity: 1 , unit_price: 200)
    invoice_item_2 = create(:invoice_item, item: item_5, invoice: invoice_3, quantity: 2 , unit_price: 150 )
    transaction_3 = create(:transaction, invoice: invoice_3, result: "success")

    expect(Merchant.by_revenue(3)).to eq([merchant_2, merchant_1, merchant_3])
  end

  it ".by_items" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 4)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 3)
    transaction_1 = create(:transaction, invoice: invoice_1, result: "success")

    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
    item_3 = create(:item, merchant: merchant_2)
    invoice_item_1 = create(:invoice_item, item: item_3, invoice: invoice_2, quantity: 10)
    transaction_2 = create(:transaction, invoice: invoice_2, result: "success")

    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_4 = create(:item, merchant: merchant_3)
    item_5 = create(:item, merchant: merchant_3)
    invoice_3 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_4, invoice: invoice_3, quantity: 1)
    invoice_item_2 = create(:invoice_item, item: item_5, invoice: invoice_3, quantity: 2)
    transaction_3 = create(:transaction, invoice: invoice_3, result: "success")

    expect(Merchant.by_items(3)).to eq([merchant_2, merchant_1, merchant_3])
  end
end
