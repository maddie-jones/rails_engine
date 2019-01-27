require 'rails_helper'

describe 'invoices API' do
  it "sends a list of invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2= create(:invoice, merchant: merchant, customer: customer)
    invoice_3= create(:invoice, merchant: merchant, customer: customer)

    get '/api/v1/invoices'

    expect(response).to be_successful
    invoice = JSON.parse(response.body)

  end
  
  xit "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

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

  it "can get one invoice by its id" do
    merchant = create(:merchant)
    customer = create(:customer)
    id = create(:invoice, customer: customer, merchant:merchant).id

    get "/api/v1/invoices/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find all invoice_items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 2)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    expect(invoice_items["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(invoice_item_2.quantity)
  end

  it "can find all transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    transaction_1 = create(:transaction, invoice: invoice, result: "success")
    transaction_2 = create(:transaction, invoice: invoice, result: "success")

    get "/api/v1/invoices/#{invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"][0]["id"]).to eq(transaction_1.id.to_s)
    expect(transactions["data"][0]["attributes"]["result"]).to eq(transaction_1.result)
    expect(transactions["data"][1]["id"]).to eq(transaction_2.id.to_s)
    expect(transactions["data"][1]["attributes"]["result"]).to eq(transaction_2.result)
  end

  it "can find all items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice, quantity: 2)

    get "/api/v1/invoices/#{invoice.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"][0]["id"]).to eq(item_1.id.to_s)
    expect(items["data"][0]["attributes"]["name"]).to eq(item_1.name)
    expect(items["data"][1]["id"]).to eq(item_2.id.to_s)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_2.name)
  end

  it "can find merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 2)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json["data"][0]["id"]).to eq(merchant.id.to_s)
    expect(merchant_json["data"][0]["attributes"]["name"]).to eq(merchant.name)
  end

  it "can find customer" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 3)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 2)

    get "/api/v1/invoices/#{invoice.id}/customer"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json["data"][0]["id"]).to eq(customer.id.to_s)
    expect(customer_json["data"][0]["attributes"]["first_name"]).to eq(customer.first_name)
  end
end
