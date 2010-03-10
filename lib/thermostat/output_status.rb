require File.join(File.dirname(__FILE__), "register_bits")

module HAIthermo
  module Thermostat
    
    module OutputStatus
      include HAIthermo::Thermostat::RegisterBits
      OUTPUT_STATUS_REGISTER = 0x48
      
      # def status_heat
      #    self.set_register_bit( OUTPUT_STATUS_REGISTER, 0 )
      #  end
      #  
      #  def status_cool
      #    self.clear_register_bit( OUTPUT_STATUS_REGISTER, 0 )
      #  end
      #  
      #  def set_fan_on
      #    self.set_register_bit( OUTPUT_STATUS_REGISTER, 3 )
      #  end
      #  
      #  def set_fan_off
      #    self.clear_register_bit( OUTPUT_STATUS_REGISTER, 3 )
      #  end
      #  
      #  def stage_1_run
      #    self.set_register_bit( OUTPUT_STATUS_REGISTER, 2 )
      #  end
      #  
      #  def stage_1_off
      #    self.clear_register_bit( OUTPUT_STATUS_REGISTER, 2 )
      #  end
      
      
      
      def set_for_heating?
        self.get_register_bit( OUTPUT_STATUS_REGISTER, 0 ) == 1
      end
      
      def set_for_cooling?
        self.get_register_bit( OUTPUT_STATUS_REGISTER, 0 ) == 0
      end
      
      def set_for_fan_on?
        self.get_register_bit( OUTPUT_STATUS_REGISTER, 3 ) == 1
      end
      
      def system_running?
        self.get_register_bit( OUTPUT_STATUS_REGISTER, 2 ) == 1
      end
      
      def heating_or_cooling?
        if system_running?
          set_for_heating? ? 'heating' : 'cooling'
        else
          'off'
        end
      end
      
      
    end
    
  end
end