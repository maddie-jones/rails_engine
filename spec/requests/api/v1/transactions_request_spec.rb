require 'rails_helper'

describe "Merchant API" do
  xit "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)

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
end
