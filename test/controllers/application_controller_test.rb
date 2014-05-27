require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "should_get_root_with_user" do
    get :root
    assert_response :success
    assert assigns(:users)
  end

  test "should_get_root_without_user" do
    session[:user_id] = nil
    get :root
    assert_response :success
    assert_nil assigns(:users)
  end

end
