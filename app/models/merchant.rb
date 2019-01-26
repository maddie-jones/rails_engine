class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.by_revenue(num)
   select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
     .joins(invoices: :invoice_items)
     .joins(invoices: :transactions)
     .where("transactions.result = ?", "success")
     .group("merchants.id")
     .order("revenue DESC")
     .limit(num)
  end

  def self.by_items(num)
    select("merchants.*, sum(invoice_items.quantity) AS quantity")
      .joins(invoices: :invoice_items)
      .joins(invoices: :transactions)
      .where("transactions.result = ?", "success")
      .group("merchants.id")
      .order("quantity DESC")
      .limit(num)
  end

  def self.revenue_by_date(date)
      joins(invoices: :invoice_items)
      .joins(invoices: :transactions)
      .where("transactions.result = ?", "success")
      .where("invoices.created_at =?", date)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def revenue_by_date(date)
      self.invoices.joins(:invoice_items, :transactions)
      .where("transactions.result = ?", "success")
      .where("invoices.created_at =?", date)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def total_revenue
    self.invoices.joins(:invoice_items, :transactions)
    .where("transactions.result = ?", "success")
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def favorite_customer(merchant)
    Customer.select("customers.*, count(transactions.id) as count")
            .joins(:invoices)
            .joins("inner join transactions on invoice_id = invoices.id")
            .where("transactions.result = ?", "success")
            .where("invoices.merchant_id =?", merchant.id)
            .group(:id)
            .order("count desc")
            .first
  end

  def all_items
    items
  end

end
