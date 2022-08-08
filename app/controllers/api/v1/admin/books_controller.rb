class Api::V1::Admin::BooksController < ApplicationController
  before_action :authorized_admin

  # GET /books
  def index
    render json: Book.all, status: 200
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

  def update

  end

  def destroy

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
