require_relative 'test_helper'


class TestRegisters < MiniTest::Test
  def setup
    @thermo = Class.new
    @thermo.extend( HAIthermo::Thermostat::Registers )
    @thermo.initialize_registers
  end



  def test_extending_registers_into_a_class_instance
    @thermo.register_names.each do |register|
      assert @thermo.methods.include?( register.to_sym )
    end
  end


  def test_register_named_returns_a_register
    assert_same(HAIthermo::Thermostat::Register::Base, @thermo.register_named(:address).class)
    assert_same(HAIthermo::Thermostat::Register::ClockAdjust, @thermo.register_named(:clock_adjust).class)
    assert_same(HAIthermo::Thermostat::Register::OmniTime, @thermo.register_named(:weekday_morning_time).class)
    assert_same(HAIthermo::Thermostat::Register::Temperature, @thermo.register_named(:weekday_morning_cool_setpoint).class)
    assert_same(HAIthermo::Thermostat::Register::OutputStatus, @thermo.register_named(:output_status).class)
    assert_same(HAIthermo::Thermostat::Register::DisplayOptions, @thermo.register_named(:display_options).class)
  end


  def test_register_named_raises_error_with_bad_register_name
    assert_raises(HAIthermo::Thermostat::Registers::RegisterError) { @thermo.register_named(:bad_reg) }
    assert_raises(HAIthermo::Thermostat::Registers::RegisterError) { @thermo.register_named(:addresses) }
  end


  def test_register_number_returns_a_register
    assert_same(HAIthermo::Thermostat::Register::Base, @thermo.register_number(0).class)
    assert_same(HAIthermo::Thermostat::Register::ClockAdjust, @thermo.register_number(14).class)
    assert_same(HAIthermo::Thermostat::Register::OmniTime, @thermo.register_number(21).class)
    assert_same(HAIthermo::Thermostat::Register::Temperature, @thermo.register_number(22).class)
    assert_same(HAIthermo::Thermostat::Register::OutputStatus, @thermo.register_number(72).class)
    assert_same(HAIthermo::Thermostat::Register::DisplayOptions, @thermo.register_number(3).class)
  end


  def test_register_number_raises_error_with_bad_register_number
    assert_raises(HAIthermo::Thermostat::Registers::RegisterError) { @thermo.register_number(-1) }
    assert_raises(HAIthermo::Thermostat::Registers::RegisterError) { @thermo.register_number(74) }
  end


  def test_register_accessor_read_and_write
    @thermo.register_names.each do |register|
      unless @thermo.register_named(register).read_only? || !@thermo.register_named(register).limits.include?(8)
         @thermo.send("#{register}").value = 8
         assert_equal(8, @thermo.send("#{register}").value)
      end
    end
  end


  # def test_setting_a_register_with_valid_value
  #   assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @thermo.address.value = 1 }
  #   assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @thermo.address.value = 127 }
  #   assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 0 }
  #   assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 1 }
  #   assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 8 }
  # end


  def test_setting_a_register_with_invalid_value
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) { @thermo.address.value = 0 }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) { @thermo.address.value = 200 }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 2 }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 10 }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) { @thermo.communication_mode.value = 11 }
  end


  def test_getting_a_register_value
    @thermo.address.value = 8
    assert_equal(8, @thermo.address.value)
    @thermo.address.value = 1
    assert_equal(1, @thermo.address.value)
    @thermo.system_options.value = 111
    assert_equal(111, @thermo.system_options.value)
    @thermo.system_options.value = 22
    assert_equal(22, @thermo.system_options.value)
    assert_equal(1, @thermo.address.value)
  end


  def test_setting_register_range
    @thermo.set_value_range(21, [5, 6, 7])
    assert_equal(5, @thermo.register_number(21).value)
    assert_equal(6, @thermo.register_number(22).value)
    assert_equal(7, @thermo.register_number(23).value)
  end


  def test_setting_register_range_string
    @thermo.set_value_range_string(21.chr + "\005\006\007")
    assert_equal(5, @thermo.register_number(21).value)
    assert_equal(6, @thermo.register_number(22).value)
    assert_equal(7, @thermo.register_number(23).value)
    @thermo.set_value_range_string(24.chr + 12.chr+16.chr+27.chr+33.chr)
    assert_equal(12, @thermo.register_number(24).value)
    assert_equal(16, @thermo.register_number(25).value)
    assert_equal(27, @thermo.register_number(26).value)
    assert_equal(33, @thermo.register_number(27).value)
  end


  def test_getting_register_range
    @thermo.set_value_range(21, [5, 6, 7])
    assert_equal([5, 6, 7], @thermo.get_value_range(21, 3))
    @thermo.set_value_range(24, [12, 16, 27, 33])
    assert_equal([12, 16, 27, 33], @thermo.get_value_range(24, 4))
  end


  def test_getting_register_range_string
    @thermo.set_value_range(21, [5, 6, 7])
    assert_equal("\005\006\007", @thermo.get_value_range_string(21, 3))
    assert_equal(3, @thermo.get_value_range_string(21, 3).length)

    @thermo.set_value_range(24, [12, 16, 27, 33])
    assert_equal(12.chr+16.chr+27.chr+33.chr, @thermo.get_value_range_string(24, 4))
    assert_equal(4, @thermo.get_value_range_string(24, 4).length)
  end



  def test_camelize
    assert_equal("Asdf", @thermo.camelize("asdf"))
    assert_equal("AsdfAsdf", @thermo.camelize("asdf_asdf"))
    assert_equal("AsdfAsdfAsdf", @thermo.camelize("asdf_asdf_asdf"))
    assert_equal("AsdfAsdfAsdf", @thermo.camelize(:asdf_asdf_asdf))
  end


  def test_constantize
    assert_same(HAIthermo::Thermostat::Register::ReadOnly, @thermo.constantize(:read_only))
    assert_same(HAIthermo::Thermostat::Register::OmniTime, @thermo.constantize(:omni_time))
    assert_same(HAIthermo::Thermostat::Register::Reserved, @thermo.constantize(:reserved))
    assert_same(false, @thermo.constantize(:asdfaasdf))
  end
end
