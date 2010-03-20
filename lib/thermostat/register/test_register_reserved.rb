require 'test/test_helper'


class TestRegisterReserved < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::Reserved.new(0, "address", (0..127))
  end

  
  def test_read_only_is_true
    assert @register.read_only?
  end

  
  def test_setting_value_raises_error
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 3 }
  end

  
  def test_getting_value_raises_error
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value }
  end

  
  def test_to_hash_returns_empty_hash
    assert_equal( {}, @register.to_hash )
  end
end