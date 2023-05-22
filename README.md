# README
This is API-only Ruby on Rails application which is backend for my college project. 
Authentication - devise and devise-jwt gems. 
Tests and documentation - rswag gem. 
Database - PostgreSQL.

Ruby version: 3.1.2
Rails version: ~> 7.0.4

First clone the repository to you local machine, then use the following commands:

bundle install

rails db:create

rails db:migrate

rails s

To access documentation go to

http://localhost:3000/api-docs

To run the test suite use command

rspec
