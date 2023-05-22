# README

This is API-only Ruby on Rails application which is backend for my college project.

## Authentication

Authentication is done using the `devise` and `devise-jwt` gems.

## Tests and documentation

Tests and documentation are done using the `rswag` gem.

## Database

The database used is PostgreSQL.

## Versions

- Ruby version: 3.1.2
- Rails version: ~> 7.0.4

## Installation

First clone the repository to your local machine, then use the following commands:

```bash
bundle install
rails db:create
rails db:migrate
rails s
```

To access documentation go to http://localhost:3000/api-docs.

## Testing

To run the test suite use command:  

```bash  
rspec
```
