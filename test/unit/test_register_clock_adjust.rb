require 'test/test_helper'


class TestRegisterClockAdjust < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::ClockAdjust.new(0, "clock_adjust", (1..59))
  end
  
  def test_degrees_converts_to_seconds_per_day
    @register.value = 30
    assert_equal(0, @register.seconds_per_day)
    @register.value = 29
    assert_equal(-1, @register.seconds_per_day)
    @register.value = 31
    assert_equal(1, @register.seconds_per_day)
    @register.value = 32
    assert_equal(2, @register.seconds_per_day)
    @register.value = 28
    assert_equal(-2, @register.seconds_per_day)
    @register.value = 1
    assert_equal(-29, @register.seconds_per_day)
    @register.value = 59
    assert_equal(29, @register.seconds_per_day)
  end
  
  
  def test_setting_seconds_per_day_sets_correct_value
    @register.seconds_per_day = 0
    assert_equal(30, @register.value)
    @register.seconds_per_day = -1
    assert_equal(29, @register.value)
    @register.seconds_per_day = 1
    assert_equal(31, @register.value)
    @register.seconds_per_day = 2
    assert_equal(32, @register.value)
    @register.seconds_per_day = -2
    assert_equal(28, @register.value)
    @register.seconds_per_day = 29
    assert_equal(59, @register.value)
    @register.seconds_per_day = -29
    assert_equal(1, @register.value)
  end
  
  
  def test_returns_seconds_per_day_string_for_display
    @register.seconds_per_day = 0
    assert_equal("0 seconds", @register.seconds_per_day_s)
    @register.seconds_per_day = 1
    assert_equal("+1 seconds", @register.seconds_per_day_s)
    @register.seconds_per_day = -1
    assert_equal("-1 seconds", @register.seconds_per_day_s)
    @register.seconds_per_day = 29
    assert_equal("+29 seconds", @register.seconds_per_day_s)
    @register.seconds_per_day = -29
    assert_equal("-29 seconds", @register.seconds_per_day_s)
  end
end