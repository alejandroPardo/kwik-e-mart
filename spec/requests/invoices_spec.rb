require 'swagger_helper'

describe 'Invoices API' do
  path '/invoices/{id}' do
    get 'Retrieves an invoice' do
      tags 'Invoices'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'invoice found' do
        schema type: :object,
               properties: {
                 id: { type: :integer }
               },
               required: ['id']

        let(:id) { Invoice.create(id: '001').id }
        run_test!
      end
    end
  end
end
