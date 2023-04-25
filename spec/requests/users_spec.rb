require 'swagger_helper'

RSpec.describe 'users', type: :request do
    path '/users/sign_in' do
        let!(:created_user) { create(:user) }

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
                header 'Authorization', schema: { type: :string, nullable: false }, 
                description: 'JWT token that is required to proceed to other pages authorized, 
                                it looks like this: "Authorization: Bearer generated.jwt.token"'

                run_test!
            end

            response(401, 'wrong parameters') do
                let!(:signin_data) { { user: { email: nil, password: created_user.password } } }

                run_test!
            end
        end
    end

    path '/users/sign_out' do
        let(:user) { create(:user) }
        
        delete('sign out') do
            tags 'Users'
            security [ bearer_auth: [] ]
            let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
            
            response(200, 'success') do
                schema type: :object, 
                    properties: {
                        message: { type: :string },
                    }

                example 'application/json', :user, {
                    message: "You are logged out."
                }

                run_test!
            end

            response(401, 'unauthorized (not logged in)') do
                let(:Authorization) { nil }
                schema type: :object, 
                    properties: {
                        message: { type: :string },
                    }

                example 'application/json', :user, {
                    message: "Hmm nothing happened."
                }

               run_test! 
            end
        end
    end

    path '/users' do
        post('create user') do
            tags 'Users'
            consumes 'application/json'
            parameter name: :signup_data, in: :body, schema: {
                type: :object,
                properties: {
                  user: { 
                    type: :object, 
                    properties: {
                      email:              { type: :string, default: 'Student99' },
                      password:              { type: :string, default: 'Password1' },
                      password_confirmation: { type: :string, default: 'Password1' }
                    },
                    required: [ 'username', 'password', 'password_confirmation' ]
                  }
                }
              }
            
            response(200, 'successful creation') do
                let(:signup_data) { { user: attributes_for(:user) } }

                schema type: :object,
                properties: {
                    message: { type: :string },
                }

                header 'Authorization', schema: { type: :string, nullable: false }, 
                description: 'JWT token that is required to proceed to other pages authorized, 
                                it looks like this: "Authorization: Bearer generated.jwt.token"'
        
                example 'application/json', :user, {
                    "message": "Signed up sucessfully."
                }

                it 'returns created status for correct email and password' do
                    post '/users', params: signup_data

                    expect(response).to have_http_status(:ok)
                end

                it "creates new user for correct email and password" do
                    expect{
                        post '/users', params: signup_data
                    }.to change(User, :count).by(1)
                end
            end

            response(422, 'unprocessable entity (wrong parameters)') do
                let!(:signup_data) { { email: 'email@example.com' } }
                schema type: :object,
                properties: {
                email: {
                    type: :array,
                    items: {
                    type: :string
                    }
                }
                }
        
                example 'application/json', :user, {
                "email": [
                    "can't be blank"
                ]
                }
                
                it 'returns unprocessable entity status for incorrect email or password' do
                    post '/users', params: signup_data

                    expect(response).to have_http_status(:unprocessable_entity)
                end

                it "creates new user for correct email and password" do
                    expect{
                        post '/users', params: signup_data
                    }.not_to change(User, :count)
                end
            end
        end
    end
end
