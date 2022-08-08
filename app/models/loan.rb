class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, presence: true, numericality: { only_integer: true}
  validates :user_id, presence: true, numericality: { only_integer: true }

  def self.loan_unavailable(user_id, book_id)
    @user = User.find_by(id: user_id)
    @book = Book.find_by(id: book_id)
    if @user.loan.count == 3
      return "Reached maximum number of loans"
    end
    if @book.copies == 0
      return "This book is out of stock"
    end
  end
end
