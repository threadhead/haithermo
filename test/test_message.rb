require 'test/test_helper'

class TestMessage < Test::Unit::TestCase
  def setup
    @message = HAIthermo::Message.new(1, 0, 1, "a")
  end
  
  def test_create_new_message
    assert_instance_of(HAIthermo::Message, @message)
  end
  
  def test_make_broadcast_message
    assert(!@message.is_broadcast_message?)
    @message.make_broadcast_message
    assert(@message.is_broadcast_message?)
  end
  
  def test_checksum_generator
    test_string = @message.hex_string_to_string("01 20 0F 03")
    assert_equal(0x33.chr, @message.generate_checksum(test_string))
    test_string = @message.hex_string_to_string("81 32 47 00 01")
    assert_equal(0xfb.chr, @message.generate_checksum(test_string))
    test_string = @message.hex_string_to_string("82 32 47 00 01")
    assert_equal(0xfc.chr, @message.generate_checksum(test_string))
  end
  
  def test_hex_string_to_string
    hex_string = "07 fc 61"
    assert_equal("\a\374a", @message.hex_string_to_string(hex_string))
    hex_string = "07 fc 45 31 00 ff"
    assert_equal("\a\374E1\000\377", @message.hex_string_to_string(hex_string))
  end
  
  def test_to_hex_string
    test_string = @message.hex_string_to_string("07 fc 61")
    assert_equal("07 fc 61", @message.to_hex_string(test_string))
    test_string = @message.hex_string_to_string("07 fc 45 31 00 ff")
    assert_equal("07 fc 45 31 00 ff", @message.to_hex_string(test_string))
  end
  
  
end