class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :item
  belongs_to :invoice
  attributes :quantity, :unit_price, :created_at, :updated_at
end
