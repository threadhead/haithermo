module HAIthermo
  require 'lib/message'
  require 'lib/messages/poll_for_registers'
  require 'lib/messages/poll_for_group1_data'
  require 'lib/messages/poll_for_group2_data'
  require 'lib/messages/set_registers'
  require 'lib/messages/receive_ACK'
  require 'lib/messages/receive_NACK'
  require 'lib/messages/receive_data'
  require 'lib/messages/receive_group1_data'
  require 'lib/messages/receive_group2_data'
  
  class MessageFactory
    # the message factory is responsible for managing the creating and routing
    # of message packets
    
    def new_message(packet)
      dissamble_packet(packet)
      # reply messages
      case @message_type
      when 0
        ReceiveACK.new(@thermo_address)
      when 1
        ReceiveNACK.new(@thermo_address)
      when 2
        ReceiveData.new(@thermo_address, @data)
      when 3
        ReceiveGroup1Data.new(@thermo_address, @data)
      when 4
        ReceiveGroup2Data.new(@thermo_address, @data)
      end
    end
    
    def poll_for_registers(thermo_address, first_register, number_of_registers)
      PollForRegisters.new(thermo_address, first_register, number_of_registers)
    end
    
    def set_registers(thermo_address, start_registers, data_bytes)
      SetRegisters.new(@thermo_address, start_registers, data_bytes)
    end
    
    def poll_for_group1_data(thermo_address)
      PollForGroup1Data.new(@thermo_address)
    end
    
    def poll_for_group2_data(thermo_address)
      PollForGroup2Data.new(@thermo_address)
    end
    
    #breaks a packet(string) apart and assigns the attributes
    def dissamble_packet(packet)
      @thermo_address = packet[0] & 0b01111111
      @host_or_reply = packet[0][7]
      @message_type = packet[1] & 0b1111
      @data_length = packet[1] & 0b11110000 / 0b10000
      @data = packet[2,@data_length]
      @checksum = packet[packet.length-1]
      @valid = validate_packet(packet)
    end
    
    
    def validate_packet(packet)
      checksum = packet[packet.length-1].chr
      data = packet[0,packet.length-1]
      check = MessageFactory.generate_checksum(data)
      check == checksum
    end
    
    
    def self.generate_checksum(packet)
      packet.sum(n = 8).chr
    end
    
    
    #converts a string representing hex values into a more readable format
    def self.to_hex_string(data_string)
      data_string.split(//).collect{ |s| s.unpack('H*')[0]}.join(' ')
    end
    

    #pass a string with a duplet representing a hex number wiht a
    #space separating each, i.e. "07 fc 91"
    def self.hex_string_to_string(hex_string)
      hex_string.split(' ').collect{ |d| d.hex.chr}.join
    end
  end
end
