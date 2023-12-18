class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product, optional: true

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
end
