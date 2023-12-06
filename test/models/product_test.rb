require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'should create product with valid attributes' do
    product = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
    assert product.valid?
  end

  test 'should not create product with invalid attributes' do
    product = Product.new(code: nil, name: nil, price: nil)
    assert_not product.valid?
  end
end
