require 'rails_helper'

RSpec.describe 'BooksController', type: :request do

  let(:author) { create(:author) }
  let(:book) { create(:book) }

  describe '#index' do
    it 'returns a successful response for index', :aggregate_failures do
      get '/api/v1/books'

      expect(JSON.parse(response.body).length).to eq(Book.count)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'returns a successful response for create', :aggregate_failures  do
      post '/api/v1/admin/book', params: { 
        book: { title: 'The Great Gatsby', copies: 3, author_id: author.id } 
      }

      expect(JSON.parse(response.body)['title']).to eq('The Great Gatsby')
      expect(JSON.parse(response.body)['copies']).to eq(3)
      expect(JSON.parse(response.body)['author_id']).to eq(author.id)
      expect(response).to have_http_status(:success)
    end

    context 'when title does not exists' do
      it 'returns error message and code', :aggregate_failures  do
        post '/api/v1/admin/book', params: { 
          book: { copies: 3, author_id: author.id } 
        }

        expect(JSON.parse(response.body)['error']).to eq('Error creating book')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when copies are smaller than 0' do
      it 'returns error message and code', :aggregate_failures  do
        post '/api/v1/admin/book', params: { 
          book: { name: 'The Great Gatsby', copies: -2, author_id: author.id } 
        } 

        expect(JSON.parse(response.body)['error']).to eq('Error creating book')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when author_id is not valid' do
      it 'returns error message and code', :aggregate_failures  do
        post '/api/v1/admin/book', params: { 
          book: { name: 'The Great Gatsby', copies: 2, author_id: 0 } 
        } 

        expect(JSON.parse(response.body)['error']).to eq('Error creating book')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#show' do
    it 'returns a successful response for show', :aggregate_failures do
      author
      book
      get '/api/v1/admin/book/2'

      current_author = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
    end
  end
end