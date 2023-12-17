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

  path '/invoices' do
    post 'Creates an invoice from the current basket' do
      tags 'Invoices'
      consumes 'application/json'
      description 'Create a new invoice based on the current basket. Fails if the basket is empty.'

      response '201', 'invoice created' do
        description 'Invoice successfully created from the current basket items.'
        before do
          allow_any_instance_of(InvoicesController).to receive(:current_basket).and_return(non_empty_basket_mock)
        end
        run_test!
      end

      response '422', 'no items in the basket' do
        description 'Fails to create an invoice due to no items in the current basket.'
        before { allow_any_instance_of(InvoicesController).to receive(:current_basket).and_return(empty_basket_mock) }
        run_test!
      end
    end
  end
end
