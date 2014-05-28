module HAIthermo
  module Message

    class ReceiveACK < Base
      def initialize(thermo_address)
        message_type = 0      
        super(thermo_address, 'reply', message_type, '')
      end
    end
    
  end
end
