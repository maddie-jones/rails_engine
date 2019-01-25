class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.by_revenue(num)
    select('merchants.id, invoices.id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins('inner join
      (SELECT "invoices".*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue
      FROM "invoices"
      INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id"
      INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id"
      WHERE "transactions"."result" = \'success\'
      GROUP BY "invoices"."id"
      ORDER BY sum(quantity * unit_price)) as ex_in)')

  end

  def all_expens_invoices
    Invoice.expensive_invoices
  end

  def all_items
    items
  end

end
