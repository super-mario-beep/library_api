require 'rails_helper'

RSpec.describe 'AuthorsController', type: :request do

  describe '#index' do
    it 'returns a successful response for index' do
      get '/api/v1/authors'

      aggregate_failures "testing response" do
        expect(JSON.parse(response.body).length).to eq(Author.all.count)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    it 'returns a successful response for create' do
      post '/api/v1/admin/author', params: { 
        author: { name: 'Ann Cleeves' } 
      }

      aggregate_failures "testing response" do
        expect(JSON.parse(response.body)['name']).to eq('Ann Cleeves')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    it 'returns a successful response for show' do
      author = Author.create( { name: 'Ann Cleeves' } )
      get '/api/v1/admin/author/2'

      aggregate_failures "testing response" do
        current_author = JSON.parse(response.body)
        expect(current_author['id']).to eq(author.id)
        expect(current_author['name']).to eq(author.name)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#update' do
    it 'returns a successful response for update' do
      author = Author.create( { name: 'David Baldacci' } )
      patch '/api/v1/admin/author/3', params: { 
        author: { name: 'Stephen King' } 
      }

      aggregate_failures "testing response" do
        expect(JSON.parse(response.body)['name']).to eq('Stephen King')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#delete' do
    it 'returns a successful response for destroy' do
      author = Author.create( { name: 'Stephen King' } )
      delete '/api/v1/admin/author/4'

      aggregate_failures "testing response" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end