require 'test/test_helper'

class TestTemperatureConversion < Test::Unit::TestCase
  include HAIthermo::TempConv
  
  def setup
    @f = 68.0
    @c = 20.0
    @omni = 120    
  end


  def test_thermo_conversions
    assert_equal( @f, c_to_f(@c) )
    assert_equal( @c, f_to_c(@f) )
    assert_equal( @omni, c_to_omnistat(@c) )
    assert_equal( @c, omnistat_to_c(@omni) )
    assert_equal( @f, omnistat_to_f(@omni) )
  end
  
  
  def test_formatting_temps_as_strings
    assert_equal("20.0C", c_formatted(@c))
    assert_equal("68F", f_formatted(@f))
    assert_equal("120Omni", o_formatted(@omni))
  end
  
  
  def test_string_outputs_with_degree_symbol
    assert_equal("20.0degC", c_formatted(@c, 'deg'))
    assert_equal("68degF", f_formatted(@f, 'deg'))
    assert_equal("120degOmni", o_formatted(@omni, 'deg'))
  end
  
end