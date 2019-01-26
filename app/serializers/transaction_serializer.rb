class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :invoice
  attributes :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at
end
