require 'swagger_helper'

RSpec.describe 'api/v1/hydrations', type: :request do

  path '/api/v1/hydrations' do
    let(:user) { create(:user) }

    post('create hydration') do
      tags 'Hydrations'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
      consumes 'application/json'
      parameter name: :hydration, in: :body, schema: {
        type: :object,
        properties: {
          cups: { type: :integer }
        }
      }

      response(201, 'created') do
        let!(:hydration) { { cups: 3 } }

        schema type: :object,
          properties: {
            id: { type: :integer },
            cups: { type: :integer, nullable: true },
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false }, 
            day_id: { type: :integer}
          }

        example 'application/json', :hydration, {
          "id": 1,
          "cups": 0,
          "created_at": "2023-04-07T19:29:10.893Z",
          "updated_at": "2023-04-07T19:29:10.893Z",
          "day_id": 4
        }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let!(:hydration) { { cups: -1 } }

        schema type: :object,
        properties: {
          cups: {
            type: :array,
            items: {
              type: :string
            }
          }
        }

        example 'application/json', :hydration, {
          "cups": [
            "must be greater than or equal to 0"
          ]
        }

        run_test!
      end
    end
  end

  path '/api/v1/hydrations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:user) { create(:user) }
    
    patch('update hydration') do
      tags 'Hydrations'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
      consumes 'application/json'
      parameter name: :hydration, in: :body, schema: {
        type: :object,
        properties: {
          cups: { type: :integer }
        }
      }

      parameter name: :id, in: :path

      response(200, 'successful') do
        let(:id) { '123' }
        let!(:hydration) { { cups: 8 } }

        schema type: :object,
          properties: {
            id: { type: :integer },
            cups: { type: :integer, nullable: true },
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false }, 
            day_id: { type: :integer}
          }

        example 'application/json', :hydration, {
          "cups": 0,
          "id": 4,
          "created_at": "2023-04-07T19:48:40.535Z",
          "updated_at": "2023-04-07T19:48:48.921Z",
          "day_id": 4
        }

        before do
          day = create(:day, user: user)
          create(:hydration, id: id, day: day, cups: 3)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        let!(:hydration) { { cups: 8 } }

        before do
          day = create(:day, user: user)
          create(:hydration, id: 122, day: day, cups: 3)
        end

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:id) { '123' }
        let!(:hydration) { { cups: -1 } }

        schema type: :object,
          properties: {
            cups: {
              type: :array,
              items: {
                type: :string
              }
            }
          }

          example 'application/json', :hydration, {
            "cups": [
              "must be greater than or equal to 0"
            ]
          }

        before do
          day = create(:day, user: user)
          create(:hydration, id: id, day: day, cups: 3)
        end

        run_test!
      end
    end

    put('update hydration') do
      tags 'Hydrations'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
      consumes 'application/json'
      parameter name: :hydration, in: :body, schema: {
        type: :object,
        properties: {
          cups: { type: :integer }
        }
      }

      parameter name: :id, in: :path

      response(200, 'successful') do
        let(:id) { '123' }
        let!(:hydration) { { cups: 8 } }

        schema type: :object,
          properties: {
            id: { type: :integer },
            cups: { type: :integer, nullable: true },
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false }, 
            day_id: { type: :integer}
          }

        example 'application/json', :hydration, {
          "cups": 0,
          "id": 4,
          "created_at": "2023-04-07T19:48:40.535Z",
          "updated_at": "2023-04-07T19:48:48.921Z",
          "day_id": 4
        }

        before do
          day = create(:day, user: user)
          create(:hydration, id: id, day: day, cups: 3)
        end

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        let!(:hydration) { { cups: 8 } }

        before do
          day = create(:day, user: user)
          create(:hydration, id: 122, day: day, cups: 3)
        end

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:id) { '123' }
        let!(:hydration) { { cups: -1 } }

        schema type: :object,
          properties: {
            cups: {
              type: :array,
              items: {
                type: :string
              }
            }
          }

          example 'application/json', :hydration, {
            "cups": [
              "must be greater than or equal to 0"
            ]
          }

        before do
          day = create(:day, user: user)
          create(:hydration, id: id, day: day, cups: 3)
        end

        run_test!
      end
    end

    delete('delete hydration') do
      tags 'Hydrations'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
      response(204, 'no content') do
        let(:day) { create(:day, user: user) }
        let(:id) { '123' }
        let!(:hydration) { create(:hydration, id: id, day: day) }

        run_test!
      end

      response(404, 'not found') do
        let(:day) { create(:day, user: user) }
        let(:id) { '123' }
        let!(:hydration) { create(:hydration, id: '122', day: day) }

        run_test!
      end
    end
  end
end
