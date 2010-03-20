module HAIthermo
  module Message
    
    class ReceiveGroup1Data < Base
      def initialize(thermo_address, data)
        message_type = 3
        super(thermo_address, 'reply', message_type, data)
      end
    
      # cool setpoint, heat setpoint, mode, fan, hold, current temperature
    
      def cool_setpoint
        @data.getbyte(0)
      end
    
      def heat_setpoint
        @data.getbyte(1)
      end
    
      def mode
        @data.getbyte(2)
      end
    
      def mode_string
        # 0=off, 1=heat, 2=cool, 3=auto) (4=Emerg heat: 
        case mode
        when 0
          'Off'
        when 1
          'Heat'
        when 2
          'Cool'
        when 3
          'Auto'
        when 4
          'Emergency Heat'
        end
      end
    
      def fan
        @data.getbyte(3)
      end
    
      def fan_string
        case fan
        when 0
          'Auto'
        when 1
          'On'
        end
      end
    
      def hold
        @data.getbyte(4)
      end
    
      def hold_string
        case hold
        when 0
          'Off'
        when 255
          'On'
        end
      end
    
      def current_temperature
        @data.getbyte(5)
      end
    end
    
  end
end
