# spec/models/invoice_spec.rb
require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'should be invalid if there is no amount' do
    items = build_list(:invoice_item, 2)
    invoice = build(:invoice, amount: nil, items:)
    expect(invoice).not_to be_valid
  end

  it 'should have many invoice items' do
    items = build_list(:invoice_item, 2)
    invoice = build(:invoice, items:)
    expect(invoice).to be_valid
    expect { invoice.save }.to change { Invoice.count }.by(1)
    expect(invoice.items.count).to eq(2)
  end
end
