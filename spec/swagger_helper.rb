# spec/swagger_helper.rb
require 'rails_helper'

RSpec.configure do |config|
  # Specify a swagger doc and configure it
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'This is the first version of my API'
      },
      basePath: '/',
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Development server'
        }
      ],
      components: {
        securitySchemes: {
          Bearer: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT
          }
        }
      },
      paths: {},
      security: [
        {
          Bearer: []
        }
      ]
    }
  }

  # Define custom RSwag configurations here
end
