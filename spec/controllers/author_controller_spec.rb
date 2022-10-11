require 'rails_helper'

RSpec.describe 'AuthorsController', type: :request do

  before(:context) do
    @author = Author.create({ name: 'Ann Cleeves' })
  end

  describe '#index' do
    it 'returns a successful response for index', :aggregate_failures do
      get '/api/v1/authors'

      expect(JSON.parse(response.body).length).to eq(Author.count)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'returns a successful response for create', :aggregate_failures  do
      post '/api/v1/admin/author', params: { 
        author: { name: 'Ann Cleeves' } 
      }

      expect(JSON.parse(response.body)['name']).to eq('Ann Cleeves')
      expect(response).to have_http_status(:success)
    end

    context 'when name does not exists' do
      it 'returns error message and code', :aggregate_failures  do
        post '/api/v1/admin/author', params: { 
          author: { title: 'David Baldacci' } 
        }

        expect(JSON.parse(response.body)['error']).to eq('Error creating author')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#show' do
    it 'returns a successful response for show', :aggregate_failures  do
      get '/api/v1/admin/author/1'

      current_author = JSON.parse(response.body)
      expect(current_author['id']).to eq(@author.id)
      expect(current_author['name']).to eq(@author.name)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    it 'returns a successful response for update', :aggregate_failures  do
      patch '/api/v1/admin/author/1', params: { 
        author: { name: 'Stephen King' } 
      }

      expect(JSON.parse(response.body)['name']).to eq('Stephen King')
      expect(response).to have_http_status(:success)
    end

    context 'when name does not exists' do
      it 'returns a sucessfull response with same name', :aggregate_failures  do
        patch '/api/v1/admin/author/1', params: { 
          author: { title: 'Stephen King' } 
        }

        expect(JSON.parse(response.body)['name']).to eq('Ann Cleeves')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#delete' do
    it 'returns a successful response for destroy', :aggregate_failures  do
      delete '/api/v1/admin/author/1'

      expect(response).to have_http_status(:success)
    end
  end
end