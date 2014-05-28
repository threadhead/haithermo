require_relative 'test_helper'


class TestRegisterThermostatMode < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::ThermostatMode.new(0, "thermostat_mode", (0..4))
  end

  def test_geting_mode
    @register.value = 0
    assert_equal('off', @register.mode)
    @register.value = 1
    assert_equal('heat', @register.mode)
    @register.value = 2
    assert_equal('cool', @register.mode)
    @register.value = 3
    assert_equal('auto', @register.mode)
    @register.value = 4
    assert_equal('emergency heat', @register.mode)
  end

  def test_setting_mode
    @register.mode = :off
    assert_equal('off', @register.mode)
    @register.mode = :heat
    assert_equal('heat', @register.mode)
    @register.mode = :cool
    assert_equal('cool', @register.mode)
    @register.mode = :auto
    assert_equal('auto', @register.mode)
  end

  def test_heating_mode
    @register.heat
    assert_equal(true, @register.heating?)
    @register.off
    assert_equal(false, @register.heating?)
  end

  def test_cooling_mode
    @register.cool
    assert_equal(true, @register.cooling?)
    @register.off
    assert_equal(false, @register.cooling?)
  end

  def test_auto_mode
    @register.auto
    assert_equal(true, @register.auto?)
    @register.off
    assert_equal(false, @register.auto?)
  end

end
