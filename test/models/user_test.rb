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

end
