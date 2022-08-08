require "test_helper"

class Api::V1::Admin::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should not save book without all params" do
    book = Book.new
    assert_not book.save, "Saved the book without title"
    book.title = "Terminator"
    book.copies = 2
    assert_not book.save, "Saved the book without author_id"
  end

  test "should not show books without autorization" do
    get "/api/v1/admin/outofstock"
    assert_response :unauthorized
  end

  test "shoud not save book with copies typeof string" do
    book = books(:three)
    book.copies = "SEVEN"
    assert_not book.save, "Saved the book with copies typeof string"
  end
end
