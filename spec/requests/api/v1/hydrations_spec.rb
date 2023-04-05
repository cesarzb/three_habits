require 'swagger_helper'

RSpec.describe 'api/v1/hydrations', type: :request do

  path '/api/v1/hydrations' do

    post('create hydration') do
      tags 'Hydrations'
      consumes 'application/json'
      parameter name: :hydration, in: :body, schema: {
        type: :object,
        properties: {
          cups: { type: :integer }
        }
      }

      response(201, 'created') do
        let!(:hydration) { { cups: 3 } } 
        run_test!
      end
    end
  end

  path '/api/v1/hydrations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    
    patch('update hydration') do
      tags 'Hydrations'
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
        before do
          day = create(:day)
          create(:hydration, id: id, day: day, cups: 3)
        end
        
        
        run_test!
      end
    end

    put('update hydration') do
      tags 'Hydrations'
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
        before do
          day = create(:day)
          create(:hydration, id: id, day: day, cups: 3)
        end

        run_test!
      end
    end

    delete('delete hydration') do
      tags 'Hydrations'
      response(204, 'no content') do
        let(:day) { create(:day) }
        let(:id) { '123' }
        let!(:hydration) { create(:hydration, id: id, day: day) }

        run_test!
      end
    end
  end
end
