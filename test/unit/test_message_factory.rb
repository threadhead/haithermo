require 'test/test_helper'

class TestMessageFactory < Test::Unit::TestCase
  def setup
    @msg_fac = HAIthermo::MessageFactory.new
    @mf = HAIthermo::MessageFactory
  end
  
  # def test_creating_poll_for_group1_data_message
  #   [1,2,5].each do |thermo|
  #     test_message = @msg_fac.poll_for_group1_data(thermo)
  #     assert_kind_of(HAIthermo::PollForGroup1Data, test_message)
  #     assert(test_message.host_message?)
  #     assert_equal(thermo, test_message.thermo_address)
  #     test_string = thermo.chr + 2.chr + (thermo + 2).chr
  #     assert_equal(test_string, test_message.assemble_packet)
  #   end
  # end
  # 
  # 
  # def test_creating_poll_for_group2_data_message
  #   [1,2,5].each do |thermo|
  #     test_message = @msg_fac.poll_for_group2_data(thermo)
  #     assert_kind_of(HAIthermo::PollForGroup2Data, test_message)
  #     assert(test_message.host_message?)
  #     assert_equal(thermo, test_message.thermo_address)
  #     test_string = thermo.chr + 3.chr + (thermo + 3).chr
  #     assert_equal(test_string, test_message.assemble_packet)
  #   end
  # end


  # def test_creating_set_registers_message
  #   test_message = @msg_fac.set_registers(4, 13, 4.chr+7.chr+9.chr)
  #   assert_kind_of(HAIthermo::SetRegisters, test_message)
  #   assert_equal(4, test_message.thermo_address)
  #   # puts @mf.to_hex_string test_message.assemble_packet
  #   test_string = @mf.hex_string_to_string("04 41 0d 04 07 09 66")
  #   assert_equal(test_string, test_message.assemble_packet)
  # end
  

  # def test_creating_poll_for_registers_message
  #   test_message = @msg_fac.poll_for_registers(2, 13, 3)
  #   assert_kind_of(HAIthermo::PollForRegisters, test_message)
  #   assert_equal(2, test_message.thermo_address)
  #   # puts @mf.to_hex_string test_message.assemble_packet
  #   test_string = @mf.hex_string_to_string("02 20 0d 03 32")
  #   assert_equal(test_string, test_message.assemble_packet)    
  # end
  
  
  def test_creating_receive_ACK_message
    test_string = @mf.hex_string_to_string("82 00 82")
    test_message = @msg_fac.new_incoming_message(test_string)
    assert_kind_of(HAIthermo::Message::ReceiveACK, test_message)
  end
  
  
  def test_creating_receive_NACK_message
    test_string = @mf.hex_string_to_string("82 01 83")
    test_message = @msg_fac.new_incoming_message(test_string)
    assert_kind_of(HAIthermo::Message::ReceiveNACK, test_message)
  end
  
  
  def test_creating_receive_data_message
    test_string = @mf.hex_string_to_string("82 32 0d 04 05 ca")
    test_message = @msg_fac.new_incoming_message(test_string)
    assert_kind_of(HAIthermo::Message::ReceiveData, test_message)
    assert_equal(13, test_message.start_register)
    assert_equal(2, test_message.register_count)
    assert_equal(4, test_message.get_register_value(13))
    assert_equal(5, test_message.get_register_value(14))
  end
  
  
  def test_creating_received_group1_data_message
    test_string = @mf.hex_string_to_string("83 63 04 05 06 07 08 09 0d")
    test_message = @msg_fac.new_incoming_message(test_string)
    assert_kind_of(HAIthermo::Message::ReceiveGroup1Data, test_message)
    assert_equal(4, test_message.cool_setpoint)
    assert_equal(5, test_message.heat_setpoint)
    assert_equal(6, test_message.mode)
    assert_equal(7, test_message.fan)
    assert_equal(8, test_message.hold)
    assert_equal(9, test_message.current_temperature)
  end
  
  
  def test_creating_received_group2_data_message
    test_string = @mf.hex_string_to_string("83 14 04 9b")
    test_message = @msg_fac.new_incoming_message(test_string)
    assert_kind_of(HAIthermo::Message::ReceiveGroup2Data, test_message)
  end
  
  
  # def test_validations_on_poll_for_registers_message
  #   assert_raise(RuntimeError) { @msg_fac.poll_for_registers(2, 13, 15) }
  #   assert_raise(RuntimeError) { @msg_fac.poll_for_registers(2, 13, 0) }
  #   assert_nothing_raised(RuntimeError) { @msg_fac.poll_for_registers(2, 13, 1) }
  #   assert_nothing_raised(RuntimeError) { @msg_fac.poll_for_registers(2, 13, 14) }
  # end
  
  
  def test_packet_validation
    test_packet = @mf.hex_string_to_string("85 3c 61 62 63 e7")
    assert(@msg_fac.validate_packet(test_packet))
    test_packet = @mf.hex_string_to_string("82 72 3B 85 72 00 00 00 74 9A")
    assert(@msg_fac.validate_packet(test_packet))
    test_packet = @mf.hex_string_to_string("02 21 44 64 CB")
    assert(@msg_fac.validate_packet(test_packet))
    test_packet = @mf.hex_string_to_string("81 22 49 00 EC")
    assert(@msg_fac.validate_packet(test_packet))
  end
  
  
  def test_checksum_generator
    test_string = @mf.hex_string_to_string("01 20 0F 03")
    assert_equal(0x33, @mf.generate_checksum(test_string))
    test_string = @mf.hex_string_to_string("81 32 47 00 01")
    assert_equal(0xfb, @mf.generate_checksum(test_string))
    test_string = @mf.hex_string_to_string("82 32 47 00 01")
    assert_equal(0xfc, @mf.generate_checksum(test_string))
  end
  
  
  def test_hex_string_to_string
    hex_string = "07 fc 61"
    assert_equal("\a\374a", @mf.hex_string_to_string(hex_string))
    hex_string = "07 fc 45 31 00 ff"
    assert_equal("\a\374E1\000\377", @mf.hex_string_to_string(hex_string))
  end
  
  
  def test_to_hex_string
    test_string = @mf.hex_string_to_string("07 fc 61")
    assert_equal("7 fc 61", @mf.to_hex_string(test_string))
    test_string = @mf.hex_string_to_string("07 fc 45 31 00 ff")
    assert_equal("7 fc 45 31 0 ff", @mf.to_hex_string(test_string))
  end
  
end