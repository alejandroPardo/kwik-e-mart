# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should create a product with valid attributes' do
    product = FactoryBot.build(:product, code: 'GR1', name: 'Green Tea', price: 3.11)
    expect(product).to be_valid
  end

  it 'should not create a product with invalid attributes' do
    product = FactoryBot.build(:product, code: nil, name: nil, price: nil)
    expect(product).not_to be_valid
  end
end
