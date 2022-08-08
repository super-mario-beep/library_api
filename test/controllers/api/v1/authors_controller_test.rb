require "test_helper"

class Api::V1::Admin::AuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should not save author without name" do
    author = Author.new
    assert_not author.save, "Saved the author without name"
  end

  test "should not update author with blank name" do
    author = authors(:one)
    author.name = ""
    assert_not author.save, "Updated the author with blank name"
  end

  test "should not show authors" do
    get "/api/v1/admin/authors"
    assert_response :unauthorized
  end
end
