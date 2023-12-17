# spec/models/promotion_discount_spec.rb
require 'rails_helper'

RSpec.describe PromotionDiscount, type: :model do
  it 'should not save promotion discount without discount_type' do
    promotion_discount = FactoryBot.build(:promotion_discount, discount_type: nil)
    expect(promotion_discount.save).to be_falsey, 'Saved promotion discount without discount_type'
  end

  it 'should save valid promotion discount' do
    promotion = FactoryBot.create(:promotion)
    promotion_discount = FactoryBot.build(:promotion_discount, promotion:, discount_type: 'percentage',
                                                               discount_value: 10.0)
    expect(promotion_discount.save).to be_truthy, 'Failed to save a valid promotion discount'
  end
end
