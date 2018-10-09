require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name:                   '',
          email:                  'user@invalid.com',
          password:               'foo',
          password_confirmation:  'bar'
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'sign up error messages' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name:                   '',
          email:                  '',
          password:               '',
          password_confirmation:  ''
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'li.error-message'
  end

  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name:                   'test',
          email:                  'test@test.com',
          password:               'testing123',
          password_confirmation:  'testing123'
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    # Note: assigns(:user) lets us access instance variables in the corresponding action,
    # the Users controller’s create action defines an @user variable so can access it here.
    # In other words: `user = @user`
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid_token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
