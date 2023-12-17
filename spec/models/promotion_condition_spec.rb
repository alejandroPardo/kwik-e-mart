# spec/models/promotion_condition_spec.rb
require 'rails_helper'

RSpec.describe PromotionCondition, type: :model do
  it 'should not save promotion condition without condition_type' do
    promotion_condition = FactoryBot.build(:promotion_condition, condition_type: nil)
    expect(promotion_condition.save).to be_falsey, 'Saved promotion condition without condition_type'
  end

  it 'should save valid promotion condition' do
    promotion = FactoryBot.create(:promotion)
    promotion_condition = FactoryBot.build(:promotion_condition, promotion:, condition_type: 'min_quantity',
                                                                 condition_value: '3')
    expect(promotion_condition.save).to be_truthy, 'Failed to save a valid promotion condition'
  end
end
