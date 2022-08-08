require "test_helper"

class Api::V1::Admin::LoansControllerTest < ActionDispatch::IntegrationTest
  test "should not save loan without all params" do
    loan = Loan.new
    assert_not loan.save, "Saved the book without params"
    loan.user_id = 4
    assert_not loan.save, "Saved the book without book_id"
  end

  test "should not give loan to user with maximum reached" do
    user = users(:one)
    book = books(:one)

    assert_equal(Loan.loan_unavailable(user.id, book.id), "Reached maximum number of loans")
  end

  test "should not give loan of book with copies" do
    user = users(:one)
    book = books(:three) #out of stock
    user.loan.destroy_all

    assert_equal(Loan.loan_unavailable(user.id, book.id), "This book is out of stock")
  end
end
