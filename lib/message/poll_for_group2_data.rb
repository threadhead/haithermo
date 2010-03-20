module HAIthermo
  module Message
    
    class PollForGroup2Data < Base
      def initialize(thermo_address)
        message_type = 3
        super(thermo_address, 'host', message_type, '')
      end
    end
    
  end
end
