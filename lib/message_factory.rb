module HAIthermo  
  class ChecksumError < StandardError; end
  class InvalidMessageType < StandardError; end
  
  class MessageFactory
    # the message factory is responsible for managing the creating and routing
    # of message packets
    
    
    
    def new_incoming_message(packet)
      # puts "packet: #{packet}"
      unless packet.nil? || packet.empty?
        dissamble_packet(packet)
        # puts "valid: #{@valid}, mt: #{@message_type}"
      
        if @valid
          case @message_type
          when 0
            Message::ReceiveACK.new(@thermo_address)
          when 1
            Message::ReceiveNACK.new(@thermo_address)
          when 2
            Message::ReceiveData.new(@thermo_address, @data)
          when 3
            Message::ReceiveGroup1Data.new(@thermo_address, @data)
          when 4
            Message::ReceiveGroup2Data.new(@thermo_address, @data)
          else
            raise InvalidMessageType.new "message type (#{@message_type}) was not recognized"
          end
        else
          raise ChecksumError.new "packet checksum did not validate"
        end
      end
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
      data = packet[0,packet.length-1]
      check = MessageFactory.generate_checksum(data)
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
