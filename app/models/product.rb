class Product < ApplicationRecord
  validates :code, :name, :price, presence: true
  validate :price_must_be_a_decimal

  has_many :promotions, dependent: :destroy

  private

  def price_must_be_a_decimal
    return if price.nil?

    errors.add(:price, 'must be a number') unless price.is_a?(Numeric)
  end
end
