require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get title:string" do
    get api_v1_books_title:string_url
    assert_response :success
  end

  test "should get copies:integer" do
    get api_v1_books_copies:integer_url
    assert_response :success
  end
end
