require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "should get path" do
    get signup_path
  end

  test "should not change count" do
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: '',
                                      email: 'test@test.com',
                                      password: 'qwe',
                                      password_confirmation: 'qwe'}}
    end
    assert_template 'users/new'
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "should shange count" do
    assert_difference 'User.count', 1 do
      post users_path, params: {
          user: {
              name: "asd",
              email: "qwe@qwcqwcas.qwe",
              password: 'asdasd',
              password_confirmation: 'asdasd'
          }
      }
      follow_redirect!
    end
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {name: 'Example User',
                                       email: 'user@example.com',
                                       password: 'password',
                                       password_confirmation: 'password'}}
    end
    assert_equal 1, ActionMailer::Base::deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as user
    assert_not is_logged_in?
    get edit_account_activation_path('invalid token', email: user.email)
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, 'qwe')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
