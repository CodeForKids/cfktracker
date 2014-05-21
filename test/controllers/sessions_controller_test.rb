require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should_signout" do
    get :destroy
    assert_response :redirect
    assert_equal flash[:notice], "You have been signed out."
  end

end
