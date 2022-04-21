require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "johndoe55", email: "johndoe5@example.com", password: "password", id: " " , admin: false)
    sign_in_as(@user)
  end
  
  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Test Title", description: "Description test"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Test Title", response.body
  end
end
