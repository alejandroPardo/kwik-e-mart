# spec/integration/baskets_spec.rb
require 'swagger_helper'

describe 'Baskets API' do
  path '/baskets' do
    get 'Retrieves basket contents' do
      tags 'Basket'
      produces 'application/json'

      response '200', 'basket contents retrieved' do
        run_test!
      end
    end
  end

  path '/baskets/{product_id}' do
    patch 'Add a product to the basket' do
      tags 'Basket'
      consumes 'application/json'
      parameter name: :product_id, in: :path, type: :integer
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer }
        },
        required: ['product_id']
      }

      response '201', 'product added to basket' do
        let(:product_id) { Product.create(code: 'CF1', name: 'Coffee', price: 11.23).id }
        let(:product) { { product_id: } }
        run_test!
      end
    end
  end

  path '/baskets/{product_id}' do
    delete 'Remove a product from the basket' do
      tags 'Basket'
      consumes 'application/json'
      parameter name: :product_id, in: :path, type: :integer

      response '204', 'product removed from basket' do
        let(:product_id) { Product.create(code: 'GR1', name: 'Green Tea', price: 3.11).id }
        run_test!
      end
    end
  end

  path '/baskets/empty_basket' do
    delete 'Empty the entire basket' do
      tags 'Basket'
      produces 'application/json'

      response '204', 'basket emptied' do
        run_test!
      end
    end
  end
end
