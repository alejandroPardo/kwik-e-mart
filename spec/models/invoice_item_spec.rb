# spec/models/invoice_item_spec.rb
require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:invoice) { FactoryBot.create(:invoice) }
  let(:product) { FactoryBot.create(:product) }

  it 'should be invalid if there is no quantity' do
    invoice_item = FactoryBot.build(:invoice_item, invoice:, product:, quantity: nil)
    expect(invoice_item).not_to be_valid
  end

  it 'should be invalid if there is no unit price' do
    invoice_item = FactoryBot.build(:invoice_item, invoice:, product:, unit_price: nil)
    expect(invoice_item).not_to be_valid
  end

  it 'should belong to an invoice and a product' do
    invoice_item = FactoryBot.build(:invoice_item, invoice:, product:)
    expect(invoice_item).to be_valid
    expect(invoice_item.invoice).to eq(invoice)
    expect(invoice_item.product).to eq(product)
  end
end
