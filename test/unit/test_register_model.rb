require 'test/test_helper'


class TestRegisterModel < Test::Unit::TestCase
  def setup
    @register = HAIthermo::Thermostat::Register::Model.new(0, "mode_of_thermostat", (0..127))
  end

  
  # def test_read_only_is_true
  #   assert @register.read_only?
  # end


  def test_returns_model_name
    assert_equal("RC-80", @register.model_name)
    @register.value = 1
    assert_equal("RC-81", @register.model_name)
    @register.value = 48
    assert_equal("RC-120", @register.model_name)
  end

end