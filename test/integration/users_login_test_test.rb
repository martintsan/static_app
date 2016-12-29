require 'test_helper'

class UsersLoginTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:martin)
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {
      session: {
        email: @user.email,
        password: 'q1w2e3r4'
      }
    }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
