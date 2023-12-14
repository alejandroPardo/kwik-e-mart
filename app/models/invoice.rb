class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :products, through: :invoice_items

  validate :must_have_at_least_one_invoice_item

  validates :amount, presence: true

  def must_have_at_least_one_invoice_item
    errors.add(:invoice_items, 'must have at least one item') if invoice_items.empty?
  end
end
