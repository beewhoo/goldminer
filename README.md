# GOLDMINER CRM
- BACKEND API

## Local Project Setup
 * pre-requisites:
    - postgreSQL. Versions 9.3 and up are supported.
    - ruby version - 3.0.0
    - rails version - 6.1.3

 * run `bundle install`

## DB setup
 * if you don't want to seed database
    create db `rails db:create`
    migrate db `rails db:migrate`

 * otherwise
  run `rails db:setup`

## Test
  run `rspec`

## API documentation
  * generate api documentation using Rswag

  run `rails rswag:specs:swaggerize`

## Run server
  run rails server `rails s`

  * after running the server go here -> http://localhost:3000/api-docs for api documentation

  * note: `post/contacts` & `put/contacts` accepts nested attributes for tags
