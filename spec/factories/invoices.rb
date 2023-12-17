# spec/factories/invoices.rb
FactoryBot.define do
  factory :invoice do
    amount { 100.00 }

    trait :with_no_invoice_items do
      invoice_items { [] }
    end

    after(:build) do |invoice|
      invoice.items << FactoryBot.build(:invoice_item, invoice:) if invoice.items.empty?
    end
  end
end
