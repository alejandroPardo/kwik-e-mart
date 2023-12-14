require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @product = products(:coffee)
  end

  test "GET should return products" do
    get products_url
    assert_response :success
  end

  test "POST should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { code: '001', name: 'Test Product', price: 10.0 } }
    end
    assert_response :created
  end

  test "POST without all parameters should fail" do
    assert_no_difference('Product.count') do
      post products_url, params: { product: { name: 'Test Product', price: 10.0 } }
    end
    assert_response :unprocessable_entity
  end

  test "PATCH should update product" do
    patch product_url(@product), params: { product: { name: 'Updated Name' } }
    assert_response :success
    @product.reload
    assert_equal 'Updated Name', @product.name
  end

  test "DELETE should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end
    assert_response :no_content
  end
end
