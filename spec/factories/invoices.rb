FactoryBot.define do
  factory :invoice do
    status { "MyText" }
    merchant { nil }
    customer { nil }
  end
end
