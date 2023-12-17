class Invoice < ApplicationRecord
  has_many :items, class_name: 'InvoiceItem', dependent: :destroy
  has_many :products, through: :invoice_items
  validates :amount, presence: true
end
