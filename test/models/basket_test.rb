require 'test_helper'

class BasketTest < ActiveSupport::TestCase
  setup do
    @basket = Basket.new
    @product = products(:coffee)
  end

  test 'should add product to basket' do
    @basket.add_item(@product)
    assert_equal 1, @basket.items[@product]
  end

  test 'should add same product to basket multiple times' do
    @basket.add_item(@product)
    @basket.add_item(@product)
    assert_equal 2, @basket.items[@product]
  end

  test 'should remove product from basket' do
    @basket.add_item(@product)
    @basket.remove_item(@product)
    assert_nil @basket.items[@product]
  end

  test 'should empty basket' do
    @basket.add_item(@product)
    @basket.empty
    assert_equal 0, @basket.items.count
  end
end
