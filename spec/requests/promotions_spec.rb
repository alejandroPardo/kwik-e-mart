require 'swagger_helper'

describe 'Promotions API' do
  path '/promotions' do
    get 'Retrieves all promotions' do
      tags 'Promotions'
      produces 'application/json'

      response '200', 'promotions found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   start_date: { type: :string, format: 'date' },
                   end_date: { type: :string, format: 'date' },
                   discounts: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         discount_type: { type: :string },
                         discount_value: { type: :string }
                       }
                     }
                   },
                   conditions: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         condition_type: { type: :string },
                         condition_value: { type: :string }
                       }
                     }
                   }
                 },
                 required: %w[id name description start_date end_date]
               }
        run_test!
      end
    end
  end

  path '/promotions/{id}' do
    get 'Retrieves a promotion' do
      tags 'Promotions'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'promotion found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 start_date: { type: :string, format: 'date' },
                 end_date: { type: :string, format: 'date' },
                 discounts: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       discount_type: { type: :string },
                       discount_value: { type: :string }
                     }
                   }
                 },
                 conditions: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       condition_type: { type: :string },
                       condition_value: { type: :string }
                     }
                   }
                 }
               },
               required: %w[id name description start_date end_date]

        let(:id) do
          Promotion.create(name: 'Test Promotion', description: 'Description', start_date: Date.today,
                           end_date: Date.today + 1.year).id
        end
        run_test!
      end
    end
  end

  path '/promotions' do
    post 'Creates a promotion' do
      tags 'Promotions'
      consumes 'application/json'
      parameter name: :promotion, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer, example: 1 },
          name: { type: :string, example: 'test' },
          description: { type: :string, example: 'test' },
          start_date: { type: :string, format: 'date', example: '2023-12-17' },
          end_date: { type: :string, format: 'date', example: '2023-12-17' },
          discounts_attributes: {
            type: :array,
            items: {
              type: :object,
              properties: {
                discount_type: { type: :string, example: 'whatever' },
                discount_value: { type: :number, example: 1 }
              }
            }
          },
          conditions_attributes: {
            type: :array,
            items: {
              type: :object,
              properties: {
                condition_type: { type: :string, example: 'whatever' },
                condition_value: { type: :string, example: '1' }
              }
            }
          }
        },
        required: %w[product_id name start_date end_date]
      }

      response '201', 'promotion created' do
        let(:promotion) { {} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:promotion) { { name: '' } }
        run_test!
      end
    end
  end

  path '/promotions/{id}' do
    put 'Updates a promotion' do
      tags 'Promotions'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :promotion, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: 'date' },
          end_date: { type: :string, format: 'date' }
        }
      }

      response '200', 'promotion updated' do
        let(:id) do
          Promotion.create(name: 'Existing Promotion', description: 'Existing Description', start_date: Date.today,
                           end_date: Date.today + 1.year).id
        end
        let(:promotion) { { name: 'Updated Promotion Name' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) do
          Promotion.create(name: 'Existing Promotion', description: 'Existing Description', start_date: Date.today,
                           end_date: Date.today + 1.year).id
        end
        let(:promotion) { { name: '' } } # Invalid data
        run_test!
      end
    end

    delete 'Deletes a promotion' do
      tags 'Promotions'
      parameter name: :id, in: :path, type: :integer

      response '204', 'promotion deleted' do
        let(:id) do
          Promotion.create(name: 'Delete Me', description: 'Delete Description', start_date: Date.today,
                           end_date: Date.today + 1.year).id
        end
        run_test!
      end
    end
  end
end
