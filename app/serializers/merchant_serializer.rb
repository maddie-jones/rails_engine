class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  attributes :name, :created_at, :updated_at
end
