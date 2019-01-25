require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)

  end
  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can single find merchant by name " do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"]["attributes"]["name"]).to eq(merchant.name)
    expect(merchant_json["data"]["id"]).to eq(merchant.id.to_s)
    expect(merchant_json["data"]["type"]).to eq("merchant")
  end

  it "can find all merchant items" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"][0]["id"]).to eq(merchant.items.first.id.to_s)
    expect(items["data"][0]["attributes"]["description"]).to eq(merchant.items.first.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(merchant.items.first.unit_price)
    expect(items["data"][1]["id"]).to eq(merchant.items.last.id.to_s)
    expect(items["data"][1]["attributes"]["description"]).to eq(merchant.items.last.description)
    expect(items["data"][1]["attributes"]["unit_price"]).to eq(merchant.items.last.unit_price)
  end

  it "can find all merchant invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"][0]["id"]).to eq(merchant.invoices.first.id.to_s)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(merchant.invoices.first.status)
    expect(invoices["data"][1]["id"]).to eq(merchant.invoices.last.id.to_s)
    expect(invoices["data"][1]["attributes"]["status"]).to eq(merchant.invoices.last.status)
  end

  it "can find_all merchant by name " do
    merchant = create(:merchant)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"]).to be_an_instance_of(Array)
    expect(merchant_json["data"][0]["attributes"]["name"]).to eq(merchant.name)
    expect(merchant_json["data"][1]["attributes"]["name"]).to eq(merchant_1.name)
    expect(merchant_json["data"][2]["attributes"]["name"]).to eq(merchant_2.name)
  end

  it "can find_all merchant by id " do
    merchant = create(:merchant)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"]).to be_an_instance_of(Array)
    expect(merchant_json["data"][0]["id"]).to eq(merchant.id.to_s)
  end

  it "can find_all merchant by created_at " do
    merchant = create(:merchant)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"]).to be_an_instance_of(Array)
    expect(merchant_json["data"][0]["id"]).to eq(merchant.id.to_s)
  end

  it "can return merchants by most_revenue" do
    x = 2
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1 , unit_price: 300 )
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 2, unit_price: 245 )

    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_2 = create(:invoice, merchant: merchant_2, customer: customer)
    item_3 = create(:item, merchant: merchant_2)
    invoice_item_1 = create(:invoice_item, item: item_3, invoice: invoice_2, quantity: 10 , unit_price: 1000)

    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_4 = create(:item, merchant: merchant_3)
    item_5 = create(:item, merchant: merchant_3)
    invoice_3 = create(:invoice, merchant: merchant_3, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_4, invoice: invoice_3, quantity: 4 , unit_price: 600)
    invoice_item_2 = create(:invoice_item, item: item_5, invoice: invoice_3, quantity: 3 , unit_price: 150 )

    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    top_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(top_merchants["data"]).to be_an_instance_of(Array)
  end
end
