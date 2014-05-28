require_relative 'test_helper'


class TestRegisterOutputStatus < MiniTest::Test
  def setup
    @register = HAIthermo::Thermostat::Register::OutputStatus.new(4, "output_status", (0..255))
  end


  def test_heating_status
    @register.value = @register.value.bit_set(0)
    assert_equal(true, @register.heating?)
    assert_equal(false, @register.cooling?)

    @register.value = @register.value.bit_clear(0)
    assert_equal(false, @register.heating?)
    assert_equal(true, @register.cooling?)
  end


  def test_fan_status
    @register.value = @register.value.bit_set(3)
    assert_equal(true, @register.fan_on?)
    assert_equal(false, @register.fan_off?)

    @register.value = @register.value.bit_clear(3)
    assert_equal(false, @register.fan_on?)
    assert_equal(true, @register.fan_off?)
  end


  def test_stage_1_running_status
    @register.value = @register.value.bit_set(2)
    assert_equal(true, @register.stage_1_running?)
    assert_equal(true, @register.running?)

    @register.value = @register.value.bit_clear(2)
    assert_equal(false, @register.stage_1_running?)
    assert_equal(false, @register.running?)
  end


  def test_stage_2_running_status
    @register.value = @register.value.bit_set(4)
    assert_equal(true, @register.stage_2_running?)

    @register.value = @register.value.bit_clear(4)
    assert_equal(false, @register.stage_2_running?)
  end


  def test_aux_heat_status
    @register.value = @register.value.bit_set(1)
    assert_equal(true, @register.aux_heat?)

    @register.value = @register.value.bit_clear(1)
    assert_equal(false, @register.aux_heat?)
  end


  def test_system_status_as_string
    @register.value = @register.value.bit_set(0) #heating/cooling
    @register.value = @register.value.bit_set(2) #on/off
    assert_equal('heating', @register.heating_or_cooling?)
    @register.value = @register.value.bit_clear(2) #on/off
    assert_equal('off', @register.heating_or_cooling?)

    @register.value = @register.value.bit_clear(0) #heating/cooling
    @register.value = @register.value.bit_set(2) #on/off
    assert_equal('cooling', @register.heating_or_cooling?)
    @register.value = @register.value.bit_clear(2) #on/off
    assert_equal('off', @register.heating_or_cooling?)
  end
end
