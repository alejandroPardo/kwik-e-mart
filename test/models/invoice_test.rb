require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'invoice should fail if no invoice items' do
    user = users(:one)
    invoice = Invoice.new(user:, amount: 100, status: 0)

    assert invoice.invalid?
  end

  test 'invoice should fail if no amount' do
    user = users(:one)
    invoice_items = [invoice_items(:one), invoice_items(:two)]
    invoice = Invoice.new(user:, invoice_items:)

    assert invoice.invalid?
  end

  test 'invoice should belong to a user and have many invoice items' do
    user = users(:one)
    invoice_items = [invoice_items(:one), invoice_items(:two)]
    invoice = Invoice.new(user:, amount: 100, status: 0, invoice_items:)

    assert invoice.valid?
    assert invoice.save, "Couldn't save a valid invoice"
    assert invoice.invoice_items.count == 2
  end
end
