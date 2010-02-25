require 'test/test_helper'

class TestRegisters < Test::Unit::TestCase
  def setup
    @registers = HAIthermo::Thermostat::Register.new(1)
  end
  
  def test_create_valid_new_registers
    assert_instance_of(HAIthermo::Thermostat::Register, HAIthermo::Thermostat::Register.new(1))
    assert_instance_of(HAIthermo::Thermostat::Register, HAIthermo::Thermostat::Register.new(127))
  end
  
  def test_create_invalid_registers_fails
    assert_raise(HAIthermo::Thermostat::RegisterError) { HAIthermo::Thermostat::Register.new(0) }
    assert_raise(HAIthermo::Thermostat::RegisterError) { HAIthermo::Thermostat::Register.new(128) } 
  end
  
  def test_setting_a_register_with_valid_value
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @registers.set_value(0, 1) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @registers.set_value(0, 127) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 0) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 1) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 8) }
  end
  
  def test_setting_a_register_with_invalid_value
    assert_raise(HAIthermo::Thermostat::RegisterError) { @registers.set_value(0, 0) }
    assert_raise(HAIthermo::Thermostat::RegisterError) { @registers.set_value(0, 200) }
    assert_raise(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 2) }
    assert_raise(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 10) }
    assert_raise(HAIthermo::Thermostat::RegisterError) { @registers.set_value(1, 11) }
  end
  
  def test_getting_a_register_value
    @registers.set_value(1, 8)
    assert_equal(8, @registers.get_value(1))
    @registers.set_value(1, 1)
    assert_equal(1, @registers.get_value(1))
    @registers.set_value(2, 111)
    assert_equal(111, @registers.get_value(2))
    @registers.set_value(2, 22)
    assert_equal(22, @registers.get_value(2))
    assert_equal(1, @registers.get_value(1))
  end
  
  def test_getting_a_register_name
    assert_equal("Address", @registers.get_name(0))
    assert_equal("Communication Mode", @registers.get_name(1))
  end
  
  def test_setting_register_value_set_updated_at
    test_time = Time.new
    Time.stubs(:new).returns(test_time)
    assert_not_equal(test_time, @registers.get_updated_at(1))
    @registers.set_value(1, 8)
    assert_equal(test_time, @registers.get_updated_at(1))
  end
end