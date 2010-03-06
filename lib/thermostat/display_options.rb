require File.join(File.dirname(__FILE__), 'register_bits')


module HAIthermo
  module Thermostat
    module DisplayOptions
      extend HAIthermo::Thermostat::RegisterBits
      DISPLAY_OPTIONS_REGISTER = 0X03
      
      def display_fahrenheit
        self.set_register_bit( DISPLAY_OPTIONS_REGISTER, 0 )
      end

      def display_celsius
        self.clear_register_bit( DISPLAY_OPTIONS_REGISTER, 0 )
      end
      
      def display_24h
        self.set_register_bit( DISPLAY_OPTIONS_REGISTER, 1 )
      end
      
      def display_ampm
        self.clear_register_bit( DISPLAY_OPTIONS_REGISTER, 1 )
      end
      
      def display_hide_time_filter
        self.set_register_bit( DISPLAY_OPTIONS_REGISTER, 4 )
      end

      def display_show_time_filer
        self.clear_register_bit( DISPLAY_OPTIONS_REGISTER, 4 )
      end
      
      def fahrenheit?
        self.get_register_bit( DISPLAY_OPTIONS_REGISTER, 0 ) == 1
      end

      def celsius?
        self.get_register_bit( DISPLAY_OPTIONS_REGISTER, 0 ) == 0
      end
      
    end
  end
end