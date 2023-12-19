# Technical Interview: Cash Register

## Overview

This application is an API-first backend designed to handle a cash register from a store. Leveraging a technology stack that includes Ruby, Rails, RSpec, it creates a simple API to work with when having to add products and discounts on a cart and computing final prices.

## Technologies Utilized

- Ruby
- Rails API for the backend web service
- RSpec for testing

## Requirements

Ensure that the following versions are installed:

Ruby: Version 3.2.2.
Rails: Version 7.1.
Additionally, refer to the specific versions mentioned in the `Gemfile.lock` for Ruby gems.

## Local Development Setup

1. **Clone the project:**

```bash
git clone git@github.com:alejandroPardo/kwik-e-mart.git
```

2. **Install Dependencies:**

```bash
bundle install
```

3. **Setup the Database:**

```bash
bundle exec rails db:setup
bundle exec rails db:migrate
bundle exec rails db:seed
```

5. **Start the Server:**

```bash
rails server
```

6. **Access the Web App at:** [http://localhost:3000/api-docs/index.html](http://localhost:3000/api-docs/index.html)

## Deployed Version

### Live Link

- [Web App Live Link](https://cart.alejandropardo.dev/)
- [OpenAPI specification](https://cart-back.alejandropardo.dev/)

## Validation, associations and assumptions for the Coding Challenge

1. Products are created according to the challenge specification, more products can be created once the database is initialized.
2. The application has no Users nor Permissions, it is designed as simple as possible and this was out of scope.
3. Cart/Basket is not persistent and only one for each basket instance.
4. Everyone can add, modify and remove products and promotions
5. Promotions are specified by two restrictions, number of products needed for it to apply (Conditions) and promotion applied to the products if it applies (Discounts)
6. After successfully adding products to the basket, an Invoice can be generated. It will calculate the final price of the basket and let you generate an invoice with it, basket will get cleared after this.
7. Promotions must have one condition and one discount, as well as an associated product.
8. Existing discount types are Free Product, Fixed Discount and Percentage discount.
9. RSwag specification helps interact with the backend, no postman needed to call the API

## Seed data explaining

By default we have 4 products, and a promotion for each of these products.

1. Green tea, with a 2x1 promotion, for every 2 green teas added to the cart, 1 will be free.
2. Strawberries, If you buy three or more, the price for each one will drop to a fixed price of 4,5
3. Coffee, If you buy three or more, you'll get a 33% discount on the price.
4. Apple, with a 3x2 promotion, for every 3 apples, you'll get a free one.

#### QA

To run automated tests, use:

```bash
rspec --force-color --format documentation
```

## Improvements

- Create Users with roles to avoid promotion modification with a permissions system
- Persist Basket on the database to allow multiple ones at the same time.
- Allow Users to have baskets for each of them.
- Validation of input data, we are now failing without traces when data is invalid, we should validate that.
- Allowing more than one condition for a discount to be added. Now only one is possible.
- Allowing more than one discount on a same promotion, now only one is being handled.
- Use different database, as of now I left the default SQLite database, this should be migrated to a more robust one.
