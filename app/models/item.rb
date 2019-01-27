class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.by_revenue(num)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue ")
    .joins(:invoice_items)
    .group(:id)
    .order("revenue desc")
    .limit(num)
  end

  
end
