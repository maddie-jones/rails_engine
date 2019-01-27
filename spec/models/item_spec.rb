require 'rails_helper'

RSpec.describe Item, type: :model do
 describe "class method" do
  it "#invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice:invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice:invoice, quantity: 2)

    expect(item.invoice_items).to eq([invoice_item_1, invoice_item_2])
  end

  it '.by_revenue' do
    x = 3
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 3, unit_price: 200)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice, quantity: 2, unit_price: 500)
    invoice_item_2 = create(:invoice_item, item: item_3, invoice: invoice, quantity: 5, unit_price: 150)
    invoice_item_2 = create(:invoice_item, item: item_3, invoice: invoice, quantity: 2, unit_price: 300)

    expect(Item.by_revenue(3)).to eq([item_3, item_2, item_1])
  end
 end
end
