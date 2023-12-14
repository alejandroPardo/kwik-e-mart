require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice = invoices(:one)
  end

  test "GET should return invoice" do
    get invoice_url(@invoice)
    assert_response :success
  end
end
