class Api::V1::AuthorsController < ApplicationController

  # GET /authors
  # GET /authors?search=sun
  def index
    if params[:search].blank?
      authors = Author.all
    else
      @parameter = "%" + params[:search].downcase + "%"
      authors = Author.all.where("lower(name) LIKE :search", search: "#{@parameter}")
      authors += Author.all.where("id IN (SELECT author_id FROM books WHERE lower(title) LIKE :search)", search: "#{@parameter}")
    end
    render json: authors
  end

  # POST /authors
  # BODY { "author": {"name": "mario duric"}}
  def create
    author = Author.new(
      name: author_params[:name].titleize
    )
    if author.save
      render json: author, status: 200
    else
      render json: {error: "Error creating author"}
    end
  end

  private

  def author_params
    params.require(:author).permit([
      :name
    ])
  end


end
  