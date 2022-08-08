class Api::V1::Admin::AuthorsController < ApplicationController
  before_action :authorized_admin
  before_action :set_author, only: [:update, :show, :destroy]

  # GET /authors
  def index
    render json: Author.all, status: 200
  end

  # POST /authors
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

  # GET /authors/1
  def show
    render json: @author
  end

  # PATCH /authors/1
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    if @author.destroy
      render statu: 200
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
  