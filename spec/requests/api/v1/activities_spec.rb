require 'swagger_helper'

RSpec.describe 'api/v1/activities', type: :request do

  path '/api/v1/activities' do
    
    post('create activity') do
      tags 'Activities'
      response(201, 'successful') do

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

    delete('delete activity') do
      tags 'Activities'
      response(204, 'no content') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:activity) { create(:activity, id: id, day: day) }
        run_test!
      end
    end
  end
end