FactoryBot.define do
  factory :item do
    association :merchant
    sequence(:name) { |n| "Thing #{n}" }
    sequence(:description) { |n| "this thing is....#{n}" }
    sequence(:unit_price) { |n| 44 + n }
  end
end
