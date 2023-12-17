class PromotionCondition < ApplicationRecord
  enum condition_type: { min_quantity: 0, max_quantity: 1, other_condition: 2 }
  validates :promotion_id, :condition_type, :condition_value, presence: true
  belongs_to :promotion, inverse_of: :conditions
end
