require 'test/test_helper'

class TestMessageFactory < Test::Unit::TestCase
  def setup
    @msg_fac = HAIthermo::MessageFactory.new
    @mf = HAIthermo::MessageFactory
  end
  
  def test_packet_validation
    test_packet = @mf.hex_string_to_string("85 3c 61 62 63 e7")
    assert(@msg_fac.validate_packet(test_packet))
    test_packet = @mf.hex_string_to_string("82 72 3B 85 72 00 00 00 74 9A")
    assert(@msg_fac.validate_packet(test_packet))
    test_packet = @mf.hex_string_to_string("02 21 44 64 CB")
    assert(@msg_fac.validate_packet(test_packet))
  end
  
  def test_checksum_generator
    test_string = @mf.hex_string_to_string("01 20 0F 03")
    assert_equal(0x33.chr, @mf.generate_checksum(test_string))
    test_string = @mf.hex_string_to_string("81 32 47 00 01")
    assert_equal(0xfb.chr, @mf.generate_checksum(test_string))
    test_string = @mf.hex_string_to_string("82 32 47 00 01")
    assert_equal(0xfc.chr, @mf.generate_checksum(test_string))
  end
  
  def test_hex_string_to_string
    hex_string = "07 fc 61"
    assert_equal("\a\374a", @mf.hex_string_to_string(hex_string))
    hex_string = "07 fc 45 31 00 ff"
    assert_equal("\a\374E1\000\377", @mf.hex_string_to_string(hex_string))
  end
  
  
  def test_to_hex_string
    test_string = @mf.hex_string_to_string("07 fc 61")
    assert_equal("07 fc 61", @mf.to_hex_string(test_string))
    test_string = @mf.hex_string_to_string("07 fc 45 31 00 ff")
    assert_equal("07 fc 45 31 00 ff", @mf.to_hex_string(test_string))
  end
  
end