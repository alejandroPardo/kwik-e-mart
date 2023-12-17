# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    code { 'XX1' }
    name { 'Generic Product' }
    price { 1.23 }

    trait :tea do
      code { 'GR1' }
      name { 'Green Tea' }
      price { 3.11 }
    end

    trait :strawberry do
      code { 'SR1' }
      name { 'Strawberries' }
      price { 5.00 }
    end

    trait :coffee do
      code { 'CF1' }
      name { 'Coffee' }
      price { 11.23 }
    end

    trait :apple do
      code { 'AP1' }
      name { 'Apples' }
      price { 6.00 }
    end
  end
end
