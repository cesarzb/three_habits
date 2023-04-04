require 'swagger_helper'

RSpec.describe 'api/v1/sleeps', type: :request do

  path '/api/v1/sleeps' do

    post('create sleep') do
      tags 'Sleeps'
      response(201, 'created') do
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
        let!(:sleep) { create(:sleep, id: id, day: day) }
        run_test!
      end
    end
  end
end
