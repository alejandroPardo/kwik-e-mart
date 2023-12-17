# spec/models/promotion_spec.rb
require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it 'should be invalid without a start_date' do
    promotion = FactoryBot.build(:promotion, start_date: nil)
    expect(promotion).not_to be_valid
    expect(promotion.errors[:start_date]).not_to be_nil
  end

  it 'should be invalid without an end_date' do
    promotion = FactoryBot.build(:promotion, end_date: nil)
    expect(promotion).not_to be_valid
    expect(promotion.errors[:end_date]).not_to be_nil
  end

  it 'should be invalid without a name' do
    promotion = FactoryBot.build(:promotion, name: nil)
    expect(promotion).not_to be_valid
    expect(promotion.errors[:name]).not_to be_nil
  end

  it 'should save valid promotion' do
    promotion = FactoryBot.build(:promotion, name: 'Sample Promotion', description: 'Sample', start_date: Date.today,
                                             end_date: Date.today + 30)
    expect(promotion.save).to be_truthy, 'Failed to save a valid promotion'
  end

  it 'should not save promotion without name' do
    promotion = FactoryBot.build(:promotion, name: nil, description: 'Sample', start_date: Date.today,
                                             end_date: Date.today + 30)
    expect(promotion.save).to be_falsey, 'Saved promotion without a name'
  end
end
