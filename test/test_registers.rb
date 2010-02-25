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
  
  def test_setting_register_range
    @registers.set_value_range(21, [5, 6, 7])
    assert_equal(5, @registers.get_value(21))
    assert_equal(6, @registers.get_value(22))
    assert_equal(7, @registers.get_value(23))
  end
  
  def test_setting_register_range_string
    @registers.set_value_range_string(21.chr + "\005\006\007")
    assert_equal(5, @registers.get_value(21))
    assert_equal(6, @registers.get_value(22))
    assert_equal(7, @registers.get_value(23))
    @registers.set_value_range_string(24.chr+12.chr+16.chr+27.chr+33.chr)
    assert_equal(12, @registers.get_value(24))
    assert_equal(16, @registers.get_value(25))
    assert_equal(27, @registers.get_value(26))
    assert_equal(33, @registers.get_value(27))
  end
  
  def test_getting_register_range
    @registers.set_value_range(21, [5, 6, 7])
    assert_equal([5, 6, 7], @registers.get_value_range(21, 3))
    @registers.set_value_range(24, [12, 16, 27, 33])
    assert_equal([12, 16, 27, 33], @registers.get_value_range(24, 4))
  end
  
  def test_getting_register_range_string
    @registers.set_value_range(21, [5, 6, 7])
    assert_equal(21.chr + "\005\006\007", @registers.get_value_range_string(21, 3))
    assert_equal(4, @registers.get_value_range_string(21, 3).length)
    
    @registers.set_value_range(24, [12, 16, 27, 33])
    assert_equal(24.chr+12.chr+16.chr+27.chr+33.chr, @registers.get_value_range_string(24, 4))
    assert_equal(5, @registers.get_value_range_string(24, 4).length)    
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