require 'swagger_helper'

RSpec.describe 'users', type: :request do
    path '/users/sign_in' do
        let!(:created_user) { create(:user) }

        get('after sign in') do
            tags 'Users'
            
            response(200, 'successful') do
                schema type: :object, 
                    properties: {
                        message: { type: :string },
                    }

                example 'application/json', :user, {
                    message: "You are logged in."
                }

                run_test!
            end
        end

        post('sign in') do
            tags 'Users'
            consumes 'application/json'
            parameter name: :signin_data, in: :body, schema: {
                type: :object,
                properties: {
                  user: { 
                    type: :object, 
                    properties: {
                      email:              { type: :string, default: 'email@example.com' },
                      password:           { type: :string, default: 'Password1' }
                    },
                    required: [ 'email', 'password' ]
                  }
                }
              }
            response(200, 'success') do
                let!(:signin_data) { { user: { email: created_user.email, password: created_user.password } } }

                run_test!
            end

            response(401, 'wrong parameters') do
                let!(:signin_data) { { user: { email: nil, password: created_user.password } } }

                run_test!
            end
        end
    end
end
