require 'test/test_helper'

class TestMessage < Test::Unit::TestCase
  def setup
    @message = HAIthermo::Message.new(1, 0, 1, "a")
    @mf = HAIthermo::MessageFactory
  end
  
  
  def test_create_new_message
    assert_instance_of(HAIthermo::Message, @message)
  end


  def test_make_broadcast_message
    assert(!@message.is_broadcast_message?)
    @message.make_broadcast_message
    assert(@message.is_broadcast_message?)
  end
      
  
  def test_creating_a_message_packet
    expected = @mf.hex_string_to_string("01 11 61 73")
    assert_equal(expected, @message.get_packet)
    
    @message = HAIthermo::Message.new(5, 1, 12, "abc")
    expected = @mf.hex_string_to_string("85 3c 61 62 63 e7")
    assert_equal(expected, @message.get_packet)
  end

end