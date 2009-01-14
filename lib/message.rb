module HAIthermo
  class Message
    def initialize(thermo_address, host_or_reply, message_type, data)
      @thermo_address = thermo_address
      @host_or_reply = host_or_reply
      @message_type = message_type
      @data = data
    end
    
    def make_broadcast_message
      @thermo_address = 0
    end
    
    #assymbles and returns the message packet as a string    
    def get_packet
      packet = ""
      packet << (@thermo_address + (host_message? ? 0b10000000 : 0b0)).chr
      packet << (@message_type + @data.length * 0b10000).chr
      packet << @data
      packet << generate_checksum(packet)
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
    
    def is_host_message?
      @host_or_reply == 0
    end
    
    def is_broadcast_message?
      @thermo_address == 0
    end
    
    def thermo_reply_message?
      @host_or_reply == 1
    end
    
    def validate_packet(packet)
      checksum = packet[packet.length-1]
      data = packet[0,packet.length-2]
      check = packet.sum(n = 8)
      # check = data.split(//).inject{ |sum,n| sum + n }
      check == checksum
    end
    
    def generate_checksum(packet)
      packet.sum(n = 8).chr
    end
    
    def to_hex_string(data_string)
      data_string.split(//).collect{ |s| s.unpack('H*')[0]}
    end

  end
end