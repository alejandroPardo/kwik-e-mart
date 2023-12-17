require 'rails_helper'

RSpec.describe 'Promotions API', type: :request do
  let!(:promotions) do
    promotion1 = create(:promotion, name: 'Buy One Get One Free - Green Tea',
                                    description: 'Buy one green tea, get one free')
    promotion2 = create(:promotion, name: 'Bulk Discount - Strawberries',
                                    description: 'Discount on bulk purchase of strawberries')
    create(:promotion_discount, promotion: promotion1, discount_type: 'free_product', discount_value: '1')
    create(:promotion_condition, promotion: promotion1, condition_type: 'min_quantity', condition_value: '2')
    create(:promotion_discount, promotion: promotion2, discount_type: 'fixed_price', discount_value: '4.50')
    create(:promotion_condition, promotion: promotion2, condition_type: 'min_quantity', condition_value: '3')
    [promotion1, promotion2]
  end

  describe 'GET /promotions' do
    before { get promotions_path }

    it 'returns a successful response' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /promotions/:id' do
    context 'with a valid id' do
      before { get promotion_path(promotions.first.id) }

      it 'returns a successful response' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context 'with an invalid id' do
      before { get promotion_path(0) }

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /promotions' do
    context 'with valid attributes' do
      let(:product_id) { create(:product).id }
      it 'creates a new promotion' do
        expect do
          post promotions_path,
               params: { promotion: { name: 'New Promotion', description: 'New Desc', start_date: Date.today,
                                      end_date: 1.year.from_now, product_id: } }
        end.to change(Promotion, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new promotion' do
        expect do
          post promotions_path, params: { promotion: { name: '' } }
        end.to_not change(Promotion, :count)
        expect(response).to have_http_status(422)
      end
    end

    context 'with discounts and conditions attributes' do
      let(:product_id) { create(:product).id }
      it 'creates a new promotion' do
        expect do
          post promotions_path,
               params: { promotion: { name: 'New Promotion', description: 'New Desc', start_date: Date.today,
                                      end_date: 1.year.from_now, product_id:, discounts_attributes: [
                                                                                {
                                                                                  discount_type: 'fixed_price',
                                                                                  discount_value: 1
                                                                                }
                                                                              ],
                                      conditions_attributes: [
                                        {
                                          condition_type: 'min_quantity',
                                          condition_value: 1
                                        }
                                      ] } }
        end.to change(Promotion, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /promotions/:id' do
    let(:promotion_to_update) { promotions.first }

    context 'with valid attributes' do
      before { put promotion_path(promotion_to_update.id), params: { promotion: { name: 'Updated Name' } } }

      it 'updates the promotion' do
        promotion_to_update.reload
        expect(promotion_to_update.name).to eq('Updated Name')
        expect(response).to have_http_status(200)
      end
    end

    context 'with valid discount attributes' do
      before do
        put promotion_path(promotion_to_update.id),
            params: { promotion: { discounts_attributes: [{ id: promotion_to_update.discounts.first.id,
                                                            discount_value: 200 }] } }
      end

      it 'updates the promotion' do
        promotion_to_update.reload
        expect(promotion_to_update.discounts.first.discount_value.to_f).to eq(200)
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid attributes' do
      before { put promotion_path(promotion_to_update.id), params: { promotion: { name: '' } } }

      it 'does not update the promotion' do
        original_name = promotion_to_update.name
        promotion_to_update.reload
        expect(promotion_to_update.name).to eq(original_name)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /promotions/:id' do
    let!(:promotion_to_destroy) { create(:promotion) }

    it 'deletes the promotion' do
      expect do
        delete promotion_path(promotion_to_destroy.id)
      end.to change(Promotion, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
