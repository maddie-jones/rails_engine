require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "#all_items" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    expect(merchant.all_items).to eq([item_1, item_2, item_3])
  end
end
