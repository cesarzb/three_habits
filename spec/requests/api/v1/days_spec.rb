require 'swagger_helper'

RSpec.describe 'api/v1/days', type: :request do

  path '/api/v1/days' do

    get('list days') do
      tags 'Days'
      response(200, 'successful') do
        schema type: :array,
          properties: [
            type: :object, 
            properties: {
              id: { type: :integer },
              date: { type: :datetime, nullable: false },
              created_at: { type: :datetime, nullable: false },
              updated_at: { type: :datetime, nullable: false }
            }
          ]

          example 'application/json', :no_days, []
          
          example 'application/json', :days, [
            {
              id: 4,
              date: "2023-03-28T22:00:00.000Z",
              created_at: "2023-03-29T14:10:43.226Z",
              updated_at: "2023-03-29T14:10:43.226Z"
            },
            {
              "id": 2,
              "date": "2023-04-04T22:00:00.000Z",
              "created_at": "2023-04-05T19:41:08.528Z",
              "updated_at": "2023-04-05T19:41:08.528Z"
            }
          ]
          
          
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

      response(422, 'unprocessable entity') do
        let!(:day) { create(:day) }

        schema type: :object,
          properties: {
            date: {
              type: :array,
              items: {
                type: :string
              }
            }
          }

          example 'application/json', :date, {
            "date": [
              "has already been taken"
            ]
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

        let(:id) { '123' }
        let!(:day) { create(:day, id: id) }

        run_test!
      end
    end

    delete('delete day') do
      tags 'Days'
      response(204, 'no content') do
        let(:id) { '123' }
        let!(:day) { create(:day, id: id) }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        let!(:day) { create(:day, id: '122') }

        run_test!
      end
    end
  end
end
