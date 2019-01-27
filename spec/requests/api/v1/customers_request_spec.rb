require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)

  end
  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can single find customer by first_name " do
    customer = create(:customer)

    get "/api/v1/customers/find?name=#{customer.first_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json["data"]["attributes"]["first_name"]).to eq(customer.first_name)
    expect(customer_json["data"]["id"]).to eq(customer.id.to_s)
    expect(customer_json["data"]["type"]).to eq("customer")
  end

  it "can find all customer invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"][0]["id"]).to eq(customer.invoices.first.id.to_s)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(customer.invoices.first.status)
    expect(invoices["data"][1]["id"]).to eq(customer.invoices.last.id.to_s)
    expect(invoices["data"][1]["attributes"]["status"]).to eq(customer.invoices.last.status)
  end

  it "can find_all customer by name " do
    customer = create(:customer)
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json["data"]).to be_an_instance_of(Array)
    expect(customer_json["data"][0]["attributes"]["first_name"]).to eq(customer.first_name)
    expect(customer_json["data"][1]["attributes"]["first_name"]).to eq(customer_1.first_name)
    expect(customer_json["data"][2]["attributes"]["first_name"]).to eq(customer_2.first_name)
  end

  it "can find_all customer by id " do
    customer = create(:customer)
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer.id}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json["data"]).to be_an_instance_of(Array)
    expect(customer_json["data"][0]["id"]).to eq(customer.id.to_s)
  end

end
