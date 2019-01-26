class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  has_many :invoices
  attributes :first_name, :last_name, :created_at, :updated_at
end
