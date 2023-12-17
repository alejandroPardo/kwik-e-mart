class PromotionDiscount < ApplicationRecord
  enum discount_type: { fixed_price: 0, percentage: 1, free_product: 2 }

  validates :promotion_id, :discount_type, :discount_value, presence: true
  
  belongs_to :promotion, inverse_of: :discounts
end
