require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: '',
          email: 'user@invalid',
          password: 'foobar',
          password_confirmation: 'foobaz'
        }
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference("User.count", 1) do
      post users_path, params: {
        user: {
          name: 'Example User',
          email: 'user@example.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert'
    assert is_logged_in?
  end
end
