require 'test_helper'

class TimetrackerTest < ActiveSupport::TestCase
  setup do
    @timetracker = Timetracker.new
  end

  test 'class_for_toggle' do
    @timetracker.received = false
    assert_equal 'thumbs-up', @timetracker.class_for_toggle

    @timetracker.received = true
    assert_equal 'thumbs-down', @timetracker.class_for_toggle
  end

  test 'received_for_toggle_as_words' do
    @timetracker.received = false
    assert_equal 'received', @timetracker.received_for_toggle_as_words

    @timetracker.received = true
    assert_equal 'unreceived', @timetracker.received_for_toggle_as_words
  end
end
