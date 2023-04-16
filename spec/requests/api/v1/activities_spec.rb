require 'swagger_helper'

RSpec.describe 'api/v1/activities', type: :request do

  path '/api/v1/activities' do
    let(:user) { create(:user) }
    
    post('create activity') do
      tags 'Activities'
      produces 'application/json'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }

      response(201, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            day_id: { type: :integer},
            date: { type: :datetime, nullable: false },
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false }
          }

        example 'application/json', :activity, {
          "id": 1,
          "day_id": 3,
          "date": "2023-04-06T15:17:11.126Z",
          "created_at": "2023-04-06T15:17:11.136Z",
          "updated_at": "2023-04-06T15:17:11.136Z"
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/activities/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:user) { create(:user) }
    
    delete('delete activity') do
      tags 'Activities'
      security [ bearer_auth: [] ]
      let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)["Authorization"] }
      response(204, 'no content') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:activity) { create(:activity, id: id, day: day) }
        run_test!
      end

      response(404, 'not found') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:activity) { create(:activity, id: 122, day: day) }
        run_test!
      end
    end
  end
end
