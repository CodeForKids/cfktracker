require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    session[:user_id] = @user.id
  end

  test 'current_user' do
    assert_equal current_user, @user
  end

  test 'gravatar' do
    assert_equal 'http://www.gravatar.com/avatar.php?default=&gravatar_id=71bc6f2bb5a0eac6060b0427358b7fed&rating=&size=', gravatar(@user.email)
  end

end
