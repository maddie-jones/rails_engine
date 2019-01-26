require 'rails_helper'
describe 'items API' do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)

  end
  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find all invoices_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 2)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
    expect(invoices["data"][0]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    expect(invoices["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    expect(invoices["data"][1]["attributes"]["quantity"]).to eq(invoice_item_2.quantity)
  end

  it "can find all merchants" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 2)

    get "/api/v1/items/#{item.id}/merchant"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"][0]["id"]).to eq(merchant.id.to_s)
    expect(merchant_json["data"][0]["attributes"]["name"]).to eq(merchant.name)
  end

end
