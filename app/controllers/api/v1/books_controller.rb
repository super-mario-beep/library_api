class Api::V1::BooksController < ApplicationController

  # GET /books
  # GET /books?search=sun
  def index
    if params[:search].blank?
      books = Book.all
    else
      @parameter = "%" + params[:search].downcase + "%"
      books = Book.all.where("lower(title) LIKE :search", search: "#{@parameter}")
      books += Book.all.where("author_id IN (SELECT id FROM authors WHERE lower(name) LIKE :search)", search: "#{@parameter}")
    end
    render json: books
  end

  # POST /books
  # BODY { "book": {"title": "Golden", "copies": 2, "author_id": 1}}
  def create
    book = Book.new(
      title: book_params[:title],
      copies: book_params[:copies],
      author_id: book_params[:author_id]
    )
    if book.save
      render json: book, status: 200
    else
      render json: {error: "Error creating book"}
    end
  end

  private

  def book_params
    params.require(:book).permit([
      :title,
      :copies,
      :author_id
    ])
  end
end
