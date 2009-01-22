module HAIthermo
  
  class Message
    # attr_reader :host_or_reply, :mesage_type
    
    def initialize(thermo_address, host_or_reply, message_type, data)
      @thermo_address = thermo_address
      @host_or_reply = host_or_reply
      @message_type = message_type
      @data = data
    end
    
    def make_broadcast_message
      @thermo_address = 0
    end
    
    #assembles and returns the message packet as a string    
    def get_packet
      # puts "host_or_reply: " + is_host_message?.to_s

      packet = ""
      packet << (@thermo_address + (is_host_message? ? 0b10000000 : 0b0)).chr
      packet << (@message_type + @data.length * 0b10000).chr
      packet << @data
      packet << HAIthermo::MessageFactory.generate_checksum(packet)
    end
    
    
    def is_host_message?
      @host_or_reply == 1
    end
    

    def is_broadcast_message?
      @thermo_address == 0
    end

    
    def thermo_reply_message?
      @host_or_reply == 1
    end

  end
end