class Api::V1::Admin::BookController < ApplicationController
  #before_action :authorized_admin
  before_action :set_book, only: [:update, :show, :destroy]

  # GET /books
  def index
    render json: Book.all, status: 200
  end

  # POST /books
  def create
    book = Book.new(
      title: book_params[:title],
      copies: book_params[:copies],
      author_id: book_params[:author_id]
    )
    if book.save
      render json: book, status: 200
    else
      render json: {error: "Error creating book"}, status: :unprocessable_entity
    end
  end

  # GET /books/1
  def show
    render json: @book
  end
  
  # PATCH /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    if @book.destroy
      render statu: 200
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # GET /books/outofstock
  def out_of_stock
    render json: Book.all.where(copies: 0), status: 200
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title,
      :copies,
      :author_id
    )
  end
end
