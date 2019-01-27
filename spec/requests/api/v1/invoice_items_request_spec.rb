require 'rails_helper'

describe "Merchant API" do
  it "sends a list of invoices_items" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1 )
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1 )
    invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_1 )


    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)

  end
  it "can get one invoice_items by its id" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1 )

    id = invoice_item_1.id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "can single find invoice_item by quantity " do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2 )

    get "/api/v1/invoice_items/find?name=#{invoice_item_1.quantity}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json["data"]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    expect(invoice_item_json["data"]["id"]).to eq(invoice_item_1.id.to_s)
    expect(invoice_item_json["data"]["type"]).to eq("invoice_item")
  end
end
