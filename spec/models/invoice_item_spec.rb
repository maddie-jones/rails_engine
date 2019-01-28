require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it "#item" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)

    expect(invoice_item_1.by_item(invoice_item_1)).to eq(item)
  end

  it "#invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)

    expect(invoice_item_1.by_invoice(invoice_item_1)).to eq(invoice)
  end
end
