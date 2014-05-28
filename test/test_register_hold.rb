require_relative 'test_helper'


class TestRegisterHold < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::Hold.new(0, "hold", [0,255])
  end

  def test_hold_status
    @register.value = 0
    assert_equal('off', @register.status)
    @register.value = 255
    assert_equal('on', @register.status)
  end


  def test_setting_hold_status
    @register.status = :on
    assert_equal(255, @register.value)
    @register.status = :off
    assert_equal(0, @register.value)
  end

  def test_hold_status_on
    @register.on
    assert_equal(true, @register.on?)
    assert_equal(false, @register.off?)
    @register.off
    assert_equal(true, @register.off?)
    assert_equal(false, @register.on?)
  end

end
