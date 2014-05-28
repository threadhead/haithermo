require_relative 'test_helper'


class TestRegisterFanStatus < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::FanStatus.new(0, "fan_status", (0..1))
  end

  def test_geting_status
    @register.value = 0
    assert_equal('auto', @register.status)
    @register.value = 1
    assert_equal('on', @register.status)
  end

  def test_setting_status
    @register.status = :auto
    assert_equal('auto', @register.status)
    @register.status = :on
    assert_equal('on', @register.status)
  end

  def test_auto_mode
    @register.auto
    assert_equal(true, @register.auto?)
    @register.on
    assert_equal(false, @register.auto?)
  end

  def test_on_status
    @register.on
    assert_equal(true, @register.on?)
    @register.auto
    assert_equal(false, @register.on?)
  end

end
