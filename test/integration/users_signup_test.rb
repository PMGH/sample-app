require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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

  test 'valid signup information' do
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
    follow_redirect!
    assert_template 'users/show'
  end
end
