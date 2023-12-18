# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # or '*' to allow all origins

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: false # Set to true if you are sending cookies/access tokens.
  end
end
