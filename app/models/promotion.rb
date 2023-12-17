class Promotion < ApplicationRecord
  has_many :discounts, class_name: 'PromotionDiscount', dependent: :destroy, inverse_of: :promotion
  has_many :conditions, class_name: 'PromotionCondition', dependent: :destroy, inverse_of: :promotion

  belongs_to :product

  accepts_nested_attributes_for :discounts, allow_destroy: true
  accepts_nested_attributes_for :conditions, allow_destroy: true
  validates :name, :start_date, :end_date, presence: true
end
