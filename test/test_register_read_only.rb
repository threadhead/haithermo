require 'test/test_helper'


class TestRegisterReadOnly < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::ReadOnly.new(0, "address", (0..127))
  end
  
  def test_read_only_is_true
    assert @register.read_only?
  end
  
  def test_setting_value_raises_error
    assert_raise(HAIthermo::Thermostat::Register::RegisterError) { @register.value = 3 }
  end
end