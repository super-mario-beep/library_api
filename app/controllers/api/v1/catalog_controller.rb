class Api::V1::CatalogController < ApplicationController

  def search_authors
    if params[:search].blank?
      authors = Author.all
    else
      @parameter = "%" + params[:search].downcase + "%"
      authors = Author.all.where("lower(name) LIKE :search", search: "#{@parameter}")
      authors += Author.all.where("id IN (SELECT author_id FROM books WHERE lower(title) LIKE :search)", search: "#{@parameter}")
    end
    render json: authors
  end

  def search_books
    if params[:search].blank?
      books = Book.all
    else
      @parameter = "%" + params[:search].downcase + "%"
      books = Book.all.where("lower(title) LIKE :search", search: "#{@parameter}")
      books += Book.all.where("author_id IN (SELECT id FROM authors WHERE lower(name) LIKE :search)", search: "#{@parameter}")
    end
    render json: books
  end

end