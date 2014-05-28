require_relative 'test_helper'

class TestControl < MiniTest::Test
  def setup
    @control = HAIthermo::Control.new(:debug => true)
  end


  def test_add_a_new_thermostat_and_get_it
    thermostats = @control.add_thermostat(1, "front")
    assert_equal thermostats[0], @control.thermostat(1)
  end


  def test_add_thermostat_check_address_range
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) {@control.add_thermostat(888, "front") }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) {@control.add_thermostat(128, "back") }
    assert_raises(HAIthermo::Thermostat::Register::RegisterError) {@control.add_thermostat(0, "upstairs") }
    # assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @control.add_thermostat(1, "front") }
    # assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @control.add_thermostat(64, "back") }
    # assert_nothing_raised(HAIthermo::Thermostat::Register::RegisterError) { @control.add_thermostat(127, "upstairs") }
  end


  def test_add_three_thermostats_and_get_each
    thermostats = @control.add_thermostat(2, "front")
    thermostats = @control.add_thermostat(4, "back")
    thermostats = @control.add_thermostat(1, "upstairs")

    assert_equal 2, @control.thermostat(2).address.value
    assert_equal 4, @control.thermostat(4).address.value
    assert_equal 1, @control.thermostat(1).address.value
  end


  def test_destroy_thermostat
    @control.add_thermostat(1, "front")
    @control.add_thermostat(3, "back")

    @control.destroy_thermostat(1)
    assert_equal 3, @control.thermostat(3).address.value
    assert_nil @control.thermostat(1)
  end


  def test_sending_a_message_to_a_thermostat
    @control.add_thermostat(1, 'front')
    @control.add_thermostat(3, 'back')

    # @control.thermostats_do(:)
  end


  def test_sending_a_string_to_the_serial_port
    self.serialport_mock_setup

    @sp_mock.expects(:gets).at_most(3).returns(82.chr+00.chr+82.chr, nil)
    assert_equal(82.chr+00.chr+82.chr, @control.read_string)
    @sp_mock.expects(:gets).at_most(3).returns(81.chr+00.chr+81.chr, nil)
    assert_equal(81.chr+00.chr+81.chr, @control.read_string)
  end


  def test_receiving_an_invalid_message_type_raises_error
    self.serialport_mock_setup
    @sp_mock.stubs(:write)
    HAIthermo.expects(:log_error).with(){|v| v.class == HAIthermo::InvalidMessageType}
    @sp_mock.expects(:gets).at_most(3).returns(81.chr+05.chr+86.chr, nil)

    @control.send_packet("asdf")
  end


  protected
  def serialport_mock_setup
    @sp_mock = mock
    @sp_mock.stubs(:read_timeout=)
    SerialPort.expects(:new).returns(@sp_mock)
    @control.open
  end
end
