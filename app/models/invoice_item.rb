class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def by_invoice(invoice_item)
    Invoice.joins(:invoice_items)
           .where("invoices.id = ?", invoice_item.invoice_id)
           .first
  end

  def by_item(invoice_item)
    Item.joins(:invoice_items)
        .where("items.id = ?", invoice_item.item_id)
        .first
  end
end
