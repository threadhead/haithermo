require 'test/test_helper'

class TestFixnumBits < Test::Unit::TestCase
  def test_setting_bits
    assert_equal(0b0010, 0b0000.bit_set(1))
    assert_equal(0b0010, 0b0010.bit_set(1))
    assert_equal(0b0100, 0b0000.bit_set(2))
    assert_equal(0b0001, 0b0000.bit_set(0))
    assert_equal(0b1000_0000, 0b0000.bit_set(7))
  end
  
  def test_clearing_bits
    assert_equal(0b1101, 0b1111.bit_clear(1))
    assert_equal(0b0000, 0b0000.bit_clear(1))
    assert_equal(0b0000, 0b0000.bit_clear(2))
    assert_equal(0b1011, 0b1111.bit_clear(2))
    assert_equal(0b1110, 0b1111.bit_clear(0))
    assert_equal(0b0111_1111, 0b1111_1111.bit_clear(7))
  end
  
  def test_getting_bits
    assert_equal(1, 0b0010.bit_get(1))
    assert_equal(0, 0b0010.bit_get(0))
    assert_equal(1, 0b0011.bit_get(0))
    assert_equal(1, 0b1000_0011.bit_get(7))
    assert_equal(0, 0b0111_0011.bit_get(7))
  end
  
  def test_bits_within_bounds
    assert_raise(ArgumentError) { -1.bit_set(0) }
    assert_raise(ArgumentError) { 256.bit_set(0) }
    assert_nothing_raised(ArgumentError) { 0.bit_set(0) }
    assert_nothing_raised(ArgumentError) { 255.bit_set(0) }
    assert_raise(ArgumentError) { -1.bit_clear(0) }
    assert_raise(ArgumentError) { 256.bit_clear(0) }
    assert_nothing_raised(ArgumentError) { 0.bit_clear(0) }
    assert_nothing_raised(ArgumentError) { 255.bit_clear(0) }
    assert_raise(ArgumentError) { -1.bit_get(0) }
    assert_raise(ArgumentError) { 256.bit_get(0) }
    assert_nothing_raised(ArgumentError) { 0.bit_get(0) }
    assert_nothing_raised(ArgumentError) { 255.bit_get(0) }
  end
end