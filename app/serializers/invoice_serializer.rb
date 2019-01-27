class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :merchant
  belongs_to :customer
  attributes :status, :created_at, :updated_at, :customer_id, :merchant_id
end
