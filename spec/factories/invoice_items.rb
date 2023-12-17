# spec/factories/invoice_items.rb
FactoryBot.define do
  factory :invoice_item do
    association :invoice
    association :product
    quantity { 1 }
    unit_price { 10.00 }
  end
end
