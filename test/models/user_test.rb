require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @julian = users(:julian)
  end

  test 'total_received_hours' do
    assert_equal 3, @julian.total_received_hours
  end

  test 'total_unreceived_hours' do
    assert_equal 3, @julian.total_received_hours
  end

  test 'weekly_average' do
    assert_equal 1.13, @julian.weekly_average
  end

  test 'monthly_average' do
    assert_equal 3.0, @julian.monthly_average
  end

end
