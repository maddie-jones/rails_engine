class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions

  def self.expensive_invoices
    joins(:invoice_items, :transactions)
      .where(transactions: {result: "success"})
      .group(:id)
      .order("sum(quantity * unit_price)")
  end

end
