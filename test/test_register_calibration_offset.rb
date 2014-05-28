require_relative 'test_helper'


class TestRegisterCalibrationOffset < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::CalibrationOffset.new(0, "calibration_offset", (1..59))
  end

  def test_degrees_converts_to_celsius
    @register.value = 30
    assert_equal(0, @register.degrees)
    @register.value = 29
    assert_equal(-0.5, @register.degrees)
    @register.value = 31
    assert_equal(0.5, @register.degrees)
    @register.value = 32
    assert_equal(1, @register.degrees)
    @register.value = 28
    assert_equal(-1, @register.degrees)
    @register.value = 1
    assert_equal(-14.5, @register.degrees)
    @register.value = 59
    assert_equal(14.5, @register.degrees)
  end


  def test_setting_degrees_sets_correct_value
    @register.degrees = 0
    assert_equal(30, @register.value)
    @register.degrees = -0.5
    assert_equal(29, @register.value)
    @register.degrees = 0.5
    assert_equal(31, @register.value)
    @register.degrees = 1
    assert_equal(32, @register.value)
    @register.degrees = -1
    assert_equal(28, @register.value)
    @register.degrees = 14.5
    assert_equal(59, @register.value)
    @register.degrees = -14.5
    assert_equal(1, @register.value)
  end


  def test_returns_degrees_string_for_display
    @register.degrees = 0
    assert_equal("0.0C", @register.degrees_s)
    @register.degrees = 0.5
    assert_equal("0.5C", @register.degrees_s)
    @register.degrees = -0.5
    assert_equal("-0.5C", @register.degrees_s)
    @register.degrees = 14.5
    assert_equal("14.5C", @register.degrees_s)
    @register.degrees = -14.5
    assert_equal("-14.5C", @register.degrees_s)
  end
end
