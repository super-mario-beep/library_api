require 'rails_helper'

RSpec.describe 'AuthorsController', type: :request do
  before(:context) do
    Author.delete_all
    Author.create( { name: 'Elly Griffiths' } )
    Author.create( { name: 'Clive Cussler' } )
  end
  
  context 'GET /index' do
    before(:context) do
      get '/api/v1/authors'
    end

    it 'returns two authors' do
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'POST /create' do
    before(:context) do
      post '/api/v1/authors/', params: { 
        author: { title: 'Ann Cleeves' } 
      }
    end

    it 'returns the name' do
      p json['name']
      expect(json['name']).to eq('Ann Cleeves')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end