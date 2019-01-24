class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def all_items
    items
  end
end
