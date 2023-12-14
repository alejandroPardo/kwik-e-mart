require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'invoice should fail if no invoice items' do
    invoice = Invoice.new(amount: 100, status: 0)

    assert invoice.invalid?
  end

  test 'invoice should fail if no amount' do
    invoice_items = [invoice_items(:one), invoice_items(:two)]
    invoice = Invoice.new(invoice_items:)

    assert invoice.invalid?
  end

  test 'invoice should have many invoice items' do
    invoice_items = [invoice_items(:one), invoice_items(:two)]
    invoice = Invoice.new(amount: 100, status: 0, invoice_items:)

    assert invoice.valid?
    assert invoice.save, "Couldn't save a valid invoice"
    assert invoice.invoice_items.count == 2
  end
end
