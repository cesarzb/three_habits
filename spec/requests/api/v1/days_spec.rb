require 'swagger_helper'

RSpec.describe 'api/v1/days', type: :request do

  path '/api/v1/days' do

    get('list days') do
      tags 'Days'
      response(200, 'successful') do

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

    post('create day') do
      tags 'Days'
      response(201, 'created') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            date: { type: :datetime, nullable: false },
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false }
          }

        example 'application/json', :day, {
          id: 4,
          date: "2023-03-28T22:00:00.000Z",
          created_at: "2023-03-29T14:10:43.226Z",
          updated_at: "2023-03-29T14:10:43.226Z"
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

  path '/api/v1/days/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show day') do
      tags 'Days'
      response(200, 'successful') do
        let(:id) { '123' }

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

    delete('delete day') do
      tags 'Days'
      response(200, 'successful') do
        let(:id) { '123' }

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
end
