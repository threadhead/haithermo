require 'test/test_helper'

class TestMessage < Test::Unit::TestCase
  def setup
  end
  
  def test_create_new_message
    @message = HAIthermo::Message.new(1, 0, 1, "a")
    assert_instance_of(HAIthermo::Message, @message)
  end
end