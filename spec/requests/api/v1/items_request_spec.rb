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

  xit "can single find merchant by name " do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"]["attributes"]["name"]).to eq(merchant.name)
    expect(merchant_json["data"]["id"]).to eq(merchant.id.to_s)
    expect(merchant_json["data"]["type"]).to eq("merchant")
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

  it 'top items by revenue' do
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

    get "/api/v1/items/most_revenue?quantity=#{x}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"][0]["id"]).to eq(item_3.id.to_s)
    expect(items["data"][0]["attributes"]["name"]).to eq(item_3.name)
    expect(items["data"][1]["id"]).to eq(item_2.id.to_s)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_2.name)
  end

end
