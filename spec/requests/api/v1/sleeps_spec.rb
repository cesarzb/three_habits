require 'swagger_helper'

RSpec.describe 'api/v1/sleeps', type: :request do

  path '/api/v1/sleeps' do

    post('create sleep') do
      tags 'Sleeps'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :sleep, in: :body, schema: {
        type: :object,
        properties: {
          length: { type: :string, format: :datetime }
        }
      }

      response(201, 'created') do
        let!(:sleep) { { length: "T15:52:28.298Z" } } 
        schema type: :object, 
          properties: {
            id: { type: :integer },
            length: { type: :datetime, nullable: true},
            created_at: { type: :datetime, nullable: false },
            updated_at: { type: :datetime, nullable: false },
            day_id: { type: :integer}
          }

          example 'application/json', :sleep, {
            "id": 1,
            "length": "2000-01-01T15:52:28.298Z",
            "created_at": "2023-04-06T15:24:47.632Z",
            "updated_at": "2023-04-06T15:24:47.632Z",
            "day_id": 3
          }
        run_test!
      end
    end
  end

  path '/api/v1/sleeps/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete sleep') do
      tags 'Sleeps'
      response(204, 'no content') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:sleep) { create(:sleep, id: id, day: day, length: 3) }
        run_test!
      end

      response(404, 'not found') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:sleep) { create(:sleep, id: 122, day: day, length: 3) }
        run_test!
      end
    end
  end
end
