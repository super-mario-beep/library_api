class Api::V1::Admin::AuthorsController < ApplicationController
  before_action :authorized_admin

  # GET /authors
  # GET /authors?search=sun
  def index
    render json: Author.all, status: 200
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

  def update

  end

  def destroy

  end

  private

  def author_params
    params.require(:author).permit([
      :name
    ])
  end


end
  