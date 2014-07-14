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
  end

  test 'should get user times' do
    get :user_times, id: @lucas.id
    assert_equal users(:lucas), assigns(:user)
    assert_equal 1, assigns(:timetrackers).length
  end

  test 'should toggle users received property on time' do
    put :toggle, timetracker_id: @timetracker
    assert assigns(:timetracker).received, 'Received wasnt true'
    assert_equal 'Successfully toggled received on Timetracker', flash[:notice]
  end

  test 'shouldnt toggle users received property on time' do
    force_fail

    put :toggle, timetracker_id: @timetracker
    assert_redirected_to timetrackers_path
    assert_equal 'Could not toggle received on Timetracker', flash[:error]
  end

  test 'should mark all times as received' do
    put :receive_all, id: @lucas
    assert_equal 1, assigns(:timetrackers).length
    assert assigns(:timetrackers).first.received
    assert_redirected_to user_times_path(@lucas)
    assert_equal 'Successfully received all times', flash[:notice]
  end

  test 'should fail to mark all times as received' do
    force_fail
    put :receive_all, id: @lucas
    assert_redirected_to user_times_path(@lucas)
    assert_equal 'Receiving one or more times failed', flash[:error]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timetracker" do
    assert_difference('Timetracker.count') do
      post :create, timetracker: { date: '05-05-14', time: 3, user_id: @user, description: 'test' }
    end

    assert_redirected_to timetrackers_path
    assert_equal 'Timetracker was successfully created.', flash[:notice]
  end

  test "should fail to create timetracker" do
    assert_no_difference('Timetracker.count') do
      post :create, timetracker: { date: '05-05-14', time: 3, user_id: @user, description: '' }
    end
    assert_equal ['Description can\'t be blank'], flash[:error].full_messages
    assert_template :new
  end

  test "should get edit" do
    get :edit, id: @timetracker
    assert_response :success
  end

  test "should update timetracker" do
    patch :update, id: @timetracker, timetracker: { time: 5 }
    assert_redirected_to timetrackers_path
    assert_equal 'Timetracker was successfully updated.', flash[:notice]
  end

  test "should fail to update timetracker" do
    patch :update, id: @timetracker, timetracker: { time: 5, description: '' }
    assert_equal ['Description can\'t be blank'], flash[:error].full_messages
    assert_template :edit
  end

  test "should destroy timetracker" do
    assert_difference('Timetracker.count', -1) do
      delete :destroy, id: @timetracker
    end

    assert_redirected_to timetrackers_path
    assert_equal 'Timetracker was successfully destroyed.', flash[:notice]
  end

  def force_fail
    Timetracker.all.each do |t|
      t.description = ''
      t.save(validate: false)
    end
  end
end
