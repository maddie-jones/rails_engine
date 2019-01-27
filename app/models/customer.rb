class Customer < ApplicationRecord
  has_many :invoices

  def all_transactions(customer)
    Transaction.joins("inner join invoices on transactions.invoice_id = invoices.id")
      .joins("inner join customers on customers.id = invoices.customer_id")
  end
end
