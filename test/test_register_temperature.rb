require 'test/test_helper'


class TestRegisterTemperature < Test::Unit::TestCase
  def setup
    @f = 68.0
    @c = 20.0
    @omni = 120    
    @register = HAIthermo::Thermostat::Register::Temperature.new(11, "outside_temperature", (0..255), @omni, :omni)
  end
  
  
  def test_creating_new_temperature_set_initial_temps
    @register = HAIthermo::Thermostat::Register::Temperature.new(11, "outside_temperature", (0..255), @omni, :omni )
    assert_equal(@omni, @register.to_o)
    assert_equal(@f, @register.to_f)
    assert_equal(@c, @register.to_c)
    @register = HAIthermo::Thermostat::Register::Temperature.new(11, "outside_temperature", (0..255), @c, :celcius )
    assert_equal(@omni, @register.to_o)
    assert_equal(@f, @register.to_f)
    assert_equal(@c, @register.to_c)
    @register = HAIthermo::Thermostat::Register::Temperature.new(11, "outside_temperature", (0..255), @f, :farenheit )
    assert_equal(@omni, @register.to_o)
    assert_equal(@f, @register.to_f)
    assert_equal(@c, @register.to_c)
  end
  
  def test_various_getter_method_aliases
    assert_equal(@omni, @register.o)
    assert_equal(@omni, @register.omni)
    assert_equal(@omni, @register.to_o)
    
    assert_equal(@c, @register.c)
    assert_equal(@c, @register.celcius)
    assert_equal(@c, @register.to_c)

    assert_equal(@f, @register.f)
    assert_equal(@f, @register.farenheit)
    assert_equal(@f, @register.to_f)
  end
  
  
  def test_string_outputs_of_temperatures
    assert_equal("20.0C", @register.to_s_c)
    assert_equal("68F", @register.to_s_f)
    assert_equal("120Omni", @register.to_s_o)
    @register.default_scale = :celcius
    assert_equal("20.0C", @register.to_s)
    @register.default_scale = :farenheit
    assert_equal("68F", @register.to_s)
    @register.default_scale = :omni
    assert_equal("120Omni", @register.to_s)
  end
  
  def test_string_outputs_with_degree_symbol
    assert_equal("20.0degC", @register.to_s_c('deg'))
    assert_equal("68degF", @register.to_s_f('deg'))
    assert_equal("120degOmni", @register.to_s_o('deg'))
  end
  
end