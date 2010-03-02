require 'lib/messages/base'
require 'lib/messages/poll_for_registers'
require 'lib/messages/poll_for_group1_data'
require 'lib/messages/poll_for_group2_data'
require 'lib/messages/set_registers'
require 'lib/messages/receive_ACK'
require 'lib/messages/receive_NACK'
require 'lib/messages/receive_data'
require 'lib/messages/receive_group1_data'
require 'lib/messages/receive_group2_data'

module HAIthermo
  # require 'ruby-debug'
  
  class MessageFactory
    # the message factory is responsible for managing the creating and routing
    # of message packets
    
    def new_incoming_message(packet)
      dissamble_packet(packet)
      # puts "valid: #{@valid}, mt: #{@message_type}"
      
      if @valid
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
      else
        raise 'packet checksum did not validate'
      end
    end
    
    def poll_for_registers(thermo_address, first_register, number_of_registers)
      PollForRegisters.new(thermo_address, first_register, number_of_registers)
    end
    
    def set_registers(thermo_address, start_register, data_bytes)
      SetRegisters.new(thermo_address, start_register, data_bytes)
    end
    
    def poll_for_group1_data(thermo_address)
      PollForGroup1Data.new(thermo_address)
    end
    
    def poll_for_group2_data(thermo_address)
      PollForGroup2Data.new(thermo_address)
    end
    
    
    #breaks a packet(string) apart and assigns the attributes
    def dissamble_packet(packet)
      packet_bytes = packet.bytes.to_a
      # debugger
      @thermo_address = packet_bytes[0] & 0b01111111
      @host_or_reply = packet_bytes[0][7]
      @message_type = packet_bytes[1] & 0b1111
      @data_length = (packet_bytes[1] & 0b11110000) / 0b10000
      @data = packet[2,@data_length]
      @checksum = packet[packet.length-1]
      @valid = validate_packet(packet)
    end
    
    
    def validate_packet(packet)
      checksum = packet[packet.length-1].getbyte(0)
      puts "checksum: #{checksum}"
      data = packet[0,packet.length-1]
      check = MessageFactory.generate_checksum(data)
      puts "check: #{check}"
      puts "calc: #{check == checksum}"
      check == checksum
    end
    
    
    def self.generate_checksum(packet)
      packet.sum(n = 8)
    end
    
    
    #converts a string representing hex values into a more readable format
    def self.to_hex_string(data_string)
      # data_string.split(//).collect{ |s| s.unpack('H*')[0]}.join(' ')  # for ruby 1.8.X
      data_string.bytes.map { |b| b.to_s(16) }.join(' ')  # for ruby 1.9.X
    end
    

    #pass a string with a duplet representing a hex number with a
    #space separating each, i.e. "07 fc 91"
    def self.hex_string_to_string(hex_string)
      hex_string.split(' ').collect{ |d| d.hex.chr}.join
    end
  end
end
