require 'test/test_helper'

class TestThermostat < Test::Unit::TestCase
  def setup
    @control = HAIthermo::Control.new(:debug => true)
  end
  
  def test_add_a_new_thermostat_and_get_it
    thermostats = @control.add_thermostat(1, "front")
    assert_equal thermostats[0], @control.thermostat(1)
  end
  
  def test_add_thermostat_check_address_range
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(888, "front") }
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(128, "back") }
    assert_raise(HAIthermo::Thermostat::RegisterError) {@control.add_thermostat(0, "upstairs") }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(1, "front") }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(64, "back") }
    assert_nothing_raised(HAIthermo::Thermostat::RegisterError) { @control.add_thermostat(127, "upstairs") }
  end
  
  def test_add_three_thermostats_and_get_each
    thermostats = @control.add_thermostat(2, "front")
    thermostats = @control.add_thermostat(4, "back")
    thermostats = @control.add_thermostat(1, "upstairs")
    
    assert_equal 2, @control.thermostat(2).address
    assert_equal 4, @control.thermostat(4).address
    assert_equal 1, @control.thermostat(1).address
  end
  
  def test_destroy_thermostat
    @control.add_thermostat(1, "front")
    @control.add_thermostat(3, "back")
    
    @control.destroy_thermostat(1)
    assert_equal 3, @control.thermostat(3).address
    assert_nil @control.thermostat(1)
  end
  
  def test_thermo_conversions
    @f = 68.0
    @c = 20.0
    @omni = 120
    @thermo = HAIthermo::Thermostat::Base.new(@control, 1, "front")
    assert_equal( @f, @thermo.c_to_f(@c) )
    assert_equal( @c, @thermo.f_to_c(@f) )
    assert_equal( @omni, @thermo.c_to_omnistat(@c) )
    assert_equal( @c, @thermo.omnistat_to_c(@omni) )
  end
end