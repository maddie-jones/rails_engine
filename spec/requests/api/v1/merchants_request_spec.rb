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

      get "/api/v1/merchants/find_all?id=#{merchant.created_at}"

      merchant_json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_json["data"]).to be_an_instance_of(Array)
      expect(merchant_json["data"][0]["created_at"]).to eq(merchant.created_at.to_s)
  end
end
