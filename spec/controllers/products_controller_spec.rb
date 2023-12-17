require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  # GET Index
  describe 'GET /products' do
    before { get '/products' }

    it 'returns products' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  # POST Create
  describe 'POST /products' do
    let(:valid_attributes) { { product: { code: '001', name: 'Test Product', price: 10.0 } } }

    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a product' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('Test Product')
      end
    end

    context 'when the request is invalid' do
      before { post '/products', params: { product: { name: 'Test Product', price: 10.0 } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # PATCH Update
  describe 'PATCH /products/:id' do
    let(:valid_attributes) { { product: { name: 'Updated Name' } } }

    context 'when the record exists' do
      before { patch "/products/#{product_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response).to have_http_status(:success)
        expect(Product.find(product_id).name).to eq('Updated Name')
      end
    end
  end

  # DELETE Destroy
  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}" }

    it 'deletes the record' do
      expect(response).to have_http_status(:no_content)
      expect(Product.find_by(id: product_id)).to be_nil
    end
  end
end
