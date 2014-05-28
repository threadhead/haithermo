require_relative 'test_helper'


class TestRegisterCurrentMode < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::CurrentMode.new(0, "current_mode", (0..2))
  end

  def test_geting_mode
    @register.value = 0
    assert_equal('off', @register.mode)
    @register.value = 1
    assert_equal('heat', @register.mode)
    @register.value = 2
    assert_equal('cool', @register.mode)
  end

  def test_heating_mode
    @register.value = 1
    assert_equal(true, @register.heating?)
    assert_equal(true, @register.heat?)
    assert_equal(false, @register.off?)
  end

  def test_cooling_mode
    @register.value = 2
    assert_equal(true, @register.cooling?)
    assert_equal(true, @register.cool?)
    assert_equal(false, @register.off?)
  end

  def test_off_mode
    @register.value = 0
    assert_equal(true, @register.off?)
    assert_equal(false, @register.heating?)
    assert_equal(false, @register.cooling?)
  end

end
