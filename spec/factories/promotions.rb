# spec/factories/promotions.rb
FactoryBot.define do
  factory :promotion do
    name { 'Generic Promotion' }
    description { 'Generic promotion description' }
    start_date { Date.today }
    end_date { 1.year.from_now }
    product

    trait :buy_one_get_one_free_tea do
      name { 'Buy One Get One Free - Green Tea' }
      description { 'Buy one green tea, get one free' }
    end

    trait :bulk_discount_strawberries do
      name { 'Bulk Discount - Strawberries' }
      description { 'Discount on bulk purchase of strawberries' }
    end

    trait :coffee_discount do
      name { 'Coffee Addict Discount' }
      description { 'Discount on bulk purchase of coffee' }

      after(:create) do |promotion|
        create(:promotion_discount, promotion:, discount_type: 'percentage', discount_value: '33.33')
        create(:promotion_condition, promotion:, condition_type: 'min_quantity', condition_value: '3')
      end
    end

    trait :buy_three_get_one_free_apples do
      name { 'Buy Three Get One Free - Apples' }
      description { 'Buy three apples, get one free' }

      after(:create) do |promotion|
        create(:promotion_discount, promotion:, discount_type: 'free_product', discount_value: '1')
        create(:promotion_condition, promotion:, condition_type: 'min_quantity', condition_value: '3')
      end
    end
  end
end
