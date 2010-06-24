require 'test/test_helper'


class TestRegisterDayOfWeek < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::DayOfWeek.new(0, "day_of_week", (0..6))
  end
  
  def test_degrees_converts_to_celsius
    @register.value = 0
    assert_equal('Monday', @register.wday)
    @register.value = 3
    assert_equal('Thursday', @register.wday)
    @register.value = 6
    assert_equal('Sunday', @register.wday)
  end
  
  
  def test_setting_degrees_sets_correct_value
    @register.wday = 'Monday'
    assert_equal(0, @register.value)
    @register.wday = 'Thursday'
    assert_equal(3, @register.value)
    @register.wday = 'Sunday'
    assert_equal(6, @register.value)
  end
  
end