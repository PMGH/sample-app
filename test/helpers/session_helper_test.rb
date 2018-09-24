require 'test_helper'

class SessionHelperTest < ActionView::TestCase
  include SessionsHelper

  def setup
    @user = User.first_or_create(
      name: "testing",
      email: "test@example.com",
      password: 'testing123',
      password_confirmation: 'testing123',
    )
  end

  test "current user not found with invalid session user_id" do
    session[:user_id] = nil
    assert_nil current_user
  end

  test "current user found with valid session user_id" do
    log_in(@user)
    assert_equal @user, current_user
  end
end
