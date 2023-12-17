# spec/factories/conditions.rb
FactoryBot.define do
  factory :promotion_condition do
    association :promotion
    condition_type { 'min_quantity' }
    condition_value { '1' }

    trait :tea_condition do
      association :promotion, factory: %i[promotion buy_one_get_one_free_tea]
      condition_value { '2' }
    end

    trait :strawberry_condition do
      association :promotion, factory: %i[promotion bulk_discount_strawberries]
      condition_value { '3' }
    end
  end
end
