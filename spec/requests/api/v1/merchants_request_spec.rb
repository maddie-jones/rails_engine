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

      merchant_json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_json["data"]["attributes"]["items"]).to eq(merchant.items)
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

      get "/api/v1/merchants/find_all?name=#{merchant.id}"

      merchant_json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant_json["data"]).to be_an_instance_of(Array)
      expect(merchant_json["data"][0]["attributes"]["id"]).to eq(merchant.id)
      expect(merchant_json["data"][1]["attributes"]["id"]).to eq(merchant_1.id)
      expect(merchant_json["data"][2]["attributes"]["id"]).to eq(merchant_2.id)
  end
end
