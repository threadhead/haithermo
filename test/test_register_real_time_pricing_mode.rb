require 'test/test_helper'


class TestRegisterRealTimePricingMode < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::ReadTimePricingMode.new(0, "rea_time_pricing_mode", (0..3))
  end
  
  def test_real_time_pricing_mode
    @register.value = 0
    assert_equal('low', @register.mode)
    @register.value = 1
    assert_equal('mid', @register.mode)
    @register.value = 2
    assert_equal('high', @register.mode)
    @register.value = 3
    assert_equal('critical', @register.mode)
  end
  
  
  def test_real_time_pricing_setting_mode
    @register.mode = :low
    assert_equal(0, @register.value)
    @register.mode = :mid
    assert_equal(1, @register.value)
    @register.mode = :high
    assert_equal(2, @register.value)
    @register.mode = :critical
    assert_equal(3, @register.value)
  end
  
  def test_real_time_pricing_mode_low
    @register.low
    assert_equal(true, @register.low?)
  end
  
  def test_real_time_pricing_mode_mid
    @register.mid
    assert_equal(true, @register.mid?)
  end
  
  def test_real_time_pricing_mode_high
    @register.high
    assert_equal(true, @register.high?)
  end
  
  def test_real_time_pricing_mode_critical
    @register.critical
    assert_equal(true, @register.critical?)
  end
  
end