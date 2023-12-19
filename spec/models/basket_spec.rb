require 'rails_helper'

RSpec.describe Basket, type: :model do
  let(:basket) { Basket.instance }
  let(:product) { FactoryBot.create(:product, name: 'Coffee', price: 11.23) }

  after(:each) do
    basket.empty
  end

  it 'should add product to basket' do
    basket.add_item(product)
    expect(basket.items[product]).to eq(1)
  end

  it 'should add same product to basket multiple times' do
    basket.add_item(product)
    basket.add_item(product)
    expect(basket.items[product]).to eq(2)
  end

  it 'should remove product from basket' do
    basket.add_item(product)
    basket.remove_item(product)
    expect(basket.items[product]).to be_nil
  end

  it 'should empty basket' do
    basket.add_item(product)
    basket.empty
    expect(basket.items.count).to eq(0)
  end
end
