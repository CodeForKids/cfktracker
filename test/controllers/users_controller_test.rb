require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @lucas = users(:lucas)
    @other = users(:other)
  end

  test "should_delete" do
    assert_no_difference('User.all.unscoped.size') do
      assert_difference('User.count',-1) do
        delete :destroy, id: @other
      end
    end

    assert_response :redirect
    assert_equal flash[:notice], "John Smith and timetrackers successfully removed"
  end

  test "should_not_delete" do
    session[:user_id] = @other.id

    assert_no_difference('User.count') do
      delete :destroy, id: @lucas
    end

    assert_response :redirect
    assert_redirected_to root_url
  end

end
