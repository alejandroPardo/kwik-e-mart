require 'swagger_helper'

describe 'Products API' do
  # GET Index
  path '/products' do
    get 'Retrieves all products' do
      tags 'Products'
      produces 'application/json'

      response '200', 'products found' do
        run_test!
      end
    end
  end

  # POST Create
  path '/products' do
    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          code: { type: :string },
          name: { type: :string },
          price: { type: :number }
        },
        required: %w[code name price]
      }

      response '201', 'product created' do
        let(:product) { { code: '001', name: 'Test Product', price: 10.0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { name: 'Test Product', price: 10.0 } }
        run_test!
      end
    end
  end

  # PATCH Update
  path '/products/{id}' do
    patch 'Updates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response '200', 'product updated' do
        let(:id) { create(:product).id }
        let(:product) { { name: 'Updated Name' } }
        run_test!
      end
    end
  end

  # DELETE Destroy
  path '/products/{id}' do
    delete 'Deletes a product' do
      tags 'Products'
      parameter name: :id, in: :path, type: :string

      response '204', 'product deleted' do
        let(:id) { create(:product).id }
        run_test!
      end
    end
  end
end
