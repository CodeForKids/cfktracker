require 'test_helper'

class TimetrackersControllerTest < ActionController::TestCase
  setup do
    @timetracker = timetrackers(:one)
    @lucas = users(:lucas)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timetrackers)
    assert_equal 1, assigns(:timetrackers).length
  end

  test 'should get user times' do
    get :user_times, id: @lucas.id
    assert_equal users(:lucas), assigns(:user)
    assert_equal 1, assigns(:timetrackers).length
  end

  test 'should toggle users received property on time' do
    put :toggle, timetracker_id: @timetracker
    assert assigns(:timetracker).received, 'Received wasnt true'
    assert_redirected_to timetrackers_path
  end

  test 'should mark all times as received' do
    put :receive_all, id: @lucas
    assert_equal 1, assigns(:timetrackers).length
    assert assigns(:timetrackers).first.received
    assert_redirected_to user_times_path(@lucas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timetracker" do
    assert_difference('Timetracker.count') do
      post :create, timetracker: { date: '05-05-14', time: 3, user_id: @user, description: 'test' }
    end

    assert_equal 2, Timetracker.where(user: @user).length
    assert_redirected_to timetrackers_path
  end

  test "should get edit" do
    get :edit, id: @timetracker
    assert_response :success
  end

  test "should update timetracker" do
    patch :update, id: @timetracker, timetracker: { time: 5 }
    assert_redirected_to timetrackers_path
  end

  test "should destroy timetracker" do
    assert_difference('Timetracker.count', -1) do
      delete :destroy, id: @timetracker
    end

    assert_redirected_to timetrackers_path
  end
end
