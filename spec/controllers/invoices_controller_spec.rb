require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /invoices/:id' do
    before do
      @invoice = create(:invoice)  # Assuming you have FactoryBot set up for your models
    end

    it 'returns a success response' do
      get invoice_url(@invoice)
      expect(response).to have_http_status(:success)
    end
  end
end
