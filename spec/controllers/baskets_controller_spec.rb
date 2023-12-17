require 'rails_helper'

RSpec.describe BasketsController, type: :request do
  before do
    @product = Product.create(code: 'CF1', name: 'Coffee', price: 11.23)
    @product2 = Product.create(code: 'GR1', name: 'Green Tea', price: 3.11)
  end

  after do
    Product.destroy_all
  end

  # GET Index - Show basket contents
  describe 'GET /basket' do
    before { get basket_index_url }

    it 'returns the basket products' do
      expect(response).to have_http_status(:success)
    end
  end

  # PATCH Update - Add product to basket
  describe 'PATCH /basket/:id' do
    it 'adds a product to the basket' do
      patch basket_url(@product), params: { product_id: @product.id }
      expect(response).to have_http_status(:created)
      expect(controller.current_basket.items.count).to eq(1)
    end

    it 'adds two different products to the basket' do
      patch basket_url(@product), params: { product_id: @product.id }
      patch basket_url(@product2), params: { product_id: @product2.id }
      expect(controller.current_basket.items.count).to eq(2)
      expect(response).to have_http_status(:created)
    end

    it 'adds the same product twice and increases quantity' do
      2.times { patch basket_url(@product), params: { product_id: @product.id } }
      expect(controller.current_basket.items.count).to eq(1)
      expect(controller.current_basket.items[@product.id.to_s]).to eq(2)
      expect(response).to have_http_status(:created)
    end
  end

  # DELETE Destroy - Remove product from basket
  describe 'DELETE /basket/:id' do
    context 'with product parameters' do
      before do
        patch basket_url(@product), params: { product_id: @product.id }
        delete basket_url(@product), params: { product_id: @product.id }
      end

      it 'removes the product from the basket' do
        expect(controller.current_basket.items.count).to eq(0)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without parameters' do
      before do
        patch basket_url(@product), params: { product_id: @product.id }
        patch basket_url(@product2), params: { product_id: @product2.id }
        delete empty_basket_basket_index_url
      end

      it 'empties the basket' do
        expect(controller.current_basket.items.count).to eq(0)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
