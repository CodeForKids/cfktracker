require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @lucas = users(:lucas)
  end

  test "should_signout" do
    get :destroy
    assert_response :redirect
    assert_equal flash[:notice], "You have been signed out."
  end

  test "should_create_session_shouldnt_add_user" do
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new(provider: @lucas.provider, uid: @lucas.uid, info: { name: @lucas.name, email: @lucas.email })

    assert_no_difference -> { User.count } do
      session[:user_id] = nil
      get :create, provider: 'google_auth_2'
    end

    assert session[:user_id]
    assert_redirected_to :timetrackers
  end

  test "should_create_session_should_add_user" do
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new(provider: @lucas.provider, uid: '12345', info: { name: 'Bob Smith', email: 'bob@codeforkids.ca' })

    assert_difference -> { User.count } do
      session[:user_id] = nil
      get :create, provider: 'google_auth_2'
    end

    assert session[:user_id]
    assert_redirected_to :timetrackers
  end


end
