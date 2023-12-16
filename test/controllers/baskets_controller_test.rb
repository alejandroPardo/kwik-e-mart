require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:coffee)
    @product2 = products(:tea)
  end

  test 'GET should return basket products' do
    get basket_index_url
    assert_response :success
  end

  test 'PATCH should add product to basket' do
    patch basket_url(@product), params: { product_id: @product.id }
    assert_equal 1, @controller.current_basket.items.count
    assert_response :created
  end

  test 'PATCH with two different products should add them to the basket' do
    patch basket_url(@product), params: { product_id: @product.id }
    patch basket_url(@product2), params: { product_id: @product2.id }
    assert_equal 2, @controller.current_basket.items.count
    assert_response :created
  end

  test 'PATCH with same product twice should add it to the basket and increase quantity' do
    patch basket_url(@product), params: { product_id: @product.id }
    patch basket_url(@product), params: { product_id: @product.id }
    assert_equal 1, @controller.current_basket.items.count
    assert_equal 2, @controller.current_basket.items[@product.id.to_s]
    assert_response :created
  end

  test 'DELETE with parameters should remove product from cart' do
    patch basket_url(@product), params: { product_id: @product.id }
    delete basket_url(@product), params: { product_id: @product.id }
    assert_equal 0, @controller.current_basket.items.count
    assert_response :no_content
  end

  test 'DELETE without parameters should empty cart' do
    patch basket_url(@product), params: { product_id: @product.id }
    patch basket_url(@product2), params: { product_id: @product2.id }
    delete empty_basket_basket_index_url
    assert_equal 0, @controller.current_basket.items.count
    assert_response :no_content
  end
end
