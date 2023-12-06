require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test 'invoice item should fail if no quantity' do
    invoice = invoices(:one)
    product = products(:tea)
    invoice_item = InvoiceItem.new(invoice:, product:, unit_price: product.price)

    assert invoice_item.invalid?
  end

  test 'invoice item should fail if no unit price' do
    invoice = invoices(:one)
    product = products(:tea)
    invoice_item = InvoiceItem.new(invoice:, product:, quantity: 1)

    assert invoice_item.invalid?
  end

  test 'invoice item should belong to an invoice and a product' do
    invoice = invoices(:one)
    product = products(:tea)
    invoice_item = InvoiceItem.new(invoice:, product:, quantity: 1, unit_price: product.price)

    assert invoice_item.valid?
    assert_equal invoice_item.invoice, invoice
    assert_equal invoice_item.product, product
  end
end
