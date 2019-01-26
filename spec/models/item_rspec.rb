require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "#invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice:invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice:invoice, quantity: 2)

    expect(item.all)
  end

end
