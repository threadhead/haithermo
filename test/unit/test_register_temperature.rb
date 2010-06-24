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
    assert_equal(@c, @register.celsius)
    assert_equal(@c, @register.celcius) # intentional
    assert_equal(@c, @register.to_c)

    assert_equal(@f, @register.f)
    assert_equal(@f, @register.fahrenheit)
    assert_equal(@f, @register.farenheit) # intentional
    assert_equal(@f, @register.to_f)
  end
  
  def test_setting_omni_temp
    @register.o = @omni
    assert_equal(@c, @register.c)
    assert_equal(@f, @register.f)
    @register.value = 0
    @register.omni = @omni
    assert_equal(@c, @register.c)
    assert_equal(@f, @register.f)
  end
  
  def test_setting_f_temp
    @register.f = @f
    assert_equal(@omni, @register.o)
    assert_equal(@c, @register.c)
    @register.value = 0
    @register.fahrenheit = @f
    assert_equal(@omni, @register.o)
    assert_equal(@c, @register.c)
  end
  
  def test_setting_c_temp
    @register.c = @c
    assert_equal(@omni, @register.o)
    assert_equal(@f, @register.f)
    @register.value = 0
    @register.celsius = @c
    assert_equal(@omni, @register.o)
    assert_equal(@f, @register.f)
  end
  
  
  def test_string_outputs_of_temperatures
    @register.default_scale = :celsius
    assert_equal("20.0C", @register.to_s)
    @register.default_scale = :fahrenheit
    assert_equal("68F", @register.to_s)
    @register.default_scale = :omni
    assert_equal("120Omni", @register.to_s)
  end
    
end