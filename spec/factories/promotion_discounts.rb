# spec/factories/discounts.rb
FactoryBot.define do
  factory :promotion_discount do
    association :promotion
    discount_type { 'fixed_price' }
    discount_value { '1.00' }

    trait :tea_discount do
      association :promotion, factory: %i[promotion buy_one_get_one_free_tea]
      discount_type { 'free_product' }
      discount_value { '1' }
    end

    trait :strawberry_discount do
      association :promotion, factory: %i[promotion bulk_discount_strawberries]
      discount_type { 'fixed_price' }
      discount_value { '4.50' }
    end
  end
end
