require 'test/test_helper'


class TestRegisterBase < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::Base.new(0, "address", (0..127))
  end
  
  
  def test_creating_new_register_within_allowable_register_number
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(0, "address", (0..127)) }
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(1, "address", (0..127)) }
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(73, "address", (0..127)) }
  end


  def test_creating_new_register_outside_allowable_register_number_raises_error
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(-1, "address", (0..127)) }
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(74, "address", (0..127)) }
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { HAIthermo::Thermostat::Register::Base.new(555, "address", (0..127)) }
  end

  
  def test_not_read_only
    assert_equal(false, @register.read_only?)
  end
  
  
  def test_setting_values_within_limits_raises_no_error
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 0 }
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 127 }
    @register = HAIthermo::Thermostat::Register::Base.new(0, "address", [0, 3, 55])
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 0 }
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 3 }
    assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 55 }
  end
  
  
  def test_setting_value_outside_limits_raises_error
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 128 }
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = -1 }
    @register = HAIthermo::Thermostat::Register::Base.new(0, "address", [0, 3, 55])
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 1 }
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 12 }
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 56 }
  end
  
  
  def test_returns_has_with_name_and_value
    @register.value = 1
    assert_equal({:address => 1}, @register.to_hash)
    @register.value = 56
    assert_equal({:address => 56}, @register.to_hash)
  end
  
  
  def test_setting_register_value_set_updated_at
    test_time = Time.now
    Time.stubs(:now).returns(test_time)
    assert_not_equal(test_time, @register.updated_at)
    @register.value = 8
    assert_equal(test_time, @register.updated_at)
  end
  
end