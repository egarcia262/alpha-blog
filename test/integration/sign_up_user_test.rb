require 'test_helper'

class SignUpUserTest < ActionDispatch::IntegrationTest
  test "get sign up user form and create new user correctly" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "User test", email: "test@email.com", password: "1234"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end
end
