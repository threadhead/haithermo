module HAIthermo
  module Message

    class Base
      attr_reader :thermo_address
    
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
      def assemble_packet
        packet = ""
        packet << (@thermo_address + (host_message? ? 0b0 : 0b10000000)).chr
        packet << (@message_type + (@data.length * 0b10000)).chr
        packet << @data
        packet << HAIthermo::MessageFactory.generate_checksum(packet)
        puts "asseble_packet: #{MessageFactory.to_hex_string(packet)}"
      end
    
    
      def host_message?
        @host_or_reply == 'host'
      end
    
      def reply_message?
        @host_or_reply != 'host'
      end
    
      def broadcast_message?
        @thermo_address == 0
      end

        
      private
      def host_or_reply_number
        @host_or_reply == 'host' ? 0 : 1
      end

    end
  end
end