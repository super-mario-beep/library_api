class Api::V1::Admin::LoansController < ApplicationController
  before_action :authorized_admin
  before_action :set_loan, only: [:update, :show, :destroy]

  # GET /loans
  def index
    render json: Load.all, status: 200
  end

  # POST /loans
  def create
    ckeck = check_is_loan_available
    if !check.blank?
      render json: {error: ckeck}, status: :unprocessable_entity
    end

    loan = Loan.new(
      user_id: loan_params[:user_id],
      book_id: loan_params[:book_id]
    )
    if loan.save
      @book.copies -= 1
      @book.save

      render json: loan, status: 200
    else
      render json: {error: "Error creating loan" }, status: :unprocessable_entity
    end
  end

  # GET /loans/1
  def show
    render json: @loan
  end

  # PATCH /loans/1
  def update
    if @loan.update(loan_params)
      render json: @loan
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /loans/1
  def destroy
    if @loan.destroy
      @book = Book.find_by(id: @loan.book_id)
      @book.copies += 1
      @book.save

      render statu: 200
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(
      :book_id,
      :user_id
    )
  end
end