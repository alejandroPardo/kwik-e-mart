# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2 as Builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Set Rails to run in production
ENV RAILS_ENV=production
ENV RACK_ENV=production

#Set up a secret key for the app
ENV SECRET_KEY_BASE=secret

# Install nodejs for asset compilation
RUN apt-get update -qq && apt-get install -y nodejs

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install gems
RUN bundle install  --without development test

# Copy the main application
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile
RUN bundle exec rails db:setup
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed

# Expose the port your app runs on
EXPOSE 9292

# Configure the main command to run when the container starts
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "9292"]
# CMD rails server -b 0.0.0.0 -p 9292
