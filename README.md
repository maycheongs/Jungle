# Jungle

A mini e-commerce application built with Rails 4.2 

## Features
* User sign up, login, logout
* Cart check-out with Stripe API
* Product ratings
* Email receipts (preview only: http://localhost:3000/rails/mailers/order_mailer/order_email)
* Admin access with basic auth to add or remove products and categories


![home](docs/root.png)
![reviews](docs/reviews.png)
![cart](docs/cart.png)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4242 4242 4242 4242 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
- PostgreSQL 9.x
- Stripe
