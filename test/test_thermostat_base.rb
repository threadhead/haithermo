require 'test/test_helper'

class TestThermostat < Test::Unit::TestCase
  def setup
    @control = HAIthermo::Control.new(:debug => true)
  end
  
  def test_add_a_new_thermostat_and_get_it
    thermostats = @control.add_thermostat(1)
    assert_equal thermostats[0], @control.get_thermostat(1)
  end
  
  def test_add_thermostat_check_address_range
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(888) }
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(128) }
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(0) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(1) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(64) }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(127) }
  end
  
  def test_add_three_thermostats_and_get_each
    thermostats = @control.add_thermostat(2)
    thermostats = @control.add_thermostat(4)
    thermostats = @control.add_thermostat(1)
    
    assert_equal 2, @control.get_thermostat(2).address
    assert_equal 4, @control.get_thermostat(4).address
    assert_equal 1, @control.get_thermostat(1).address
  end
  
  def test_destroy_thermostat
    @control.add_thermostat(1)
    @control.add_thermostat(3)
    
    @control.destroy_thermostat(1)
    assert_equal 3, @control.get_thermostat(3).address
    assert_nil @control.get_thermostat(1)
  end
  
  def test_thermo_conversions
    @f = 68.0
    @c = 20.0
    @omni = 120
    @thermo = HAIthermo::Thermostat::Base.new(@control, 1)
    assert_equal( @f, @thermo.c_to_f(@c) )
    assert_equal( @c, @thermo.f_to_c(@f) )
    assert_equal( @omni, @thermo.c_to_omnistat(@c) )
    assert_equal( @c, @thermo.omnistat_to_c(@omni) )
  end
end