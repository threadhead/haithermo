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
    test_string = 0x01.chr<<0x20.chr<<0x0F.chr<<0x03.chr
    assert_equal(0x33.chr, @message.generate_checksum(test_string))
    test_string = 0x81.chr<<0x32.chr<<0x47.chr<<0x00.chr<<0x01.chr
    assert_equal(0xfb.chr, @message.generate_checksum(test_string))
    test_string = 0x82.chr<<0x32.chr<<0x47.chr<<0x00.chr<<0x01.chr
    assert_equal(0xfc.chr, @message.generate_checksum(test_string))
  end
  
  
end