require File.join(File.dirname(__FILE__), 'thermostat', 'register_bits')


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



      # def set_register_bit( register, bit_to_set )
      #   @registers.set_value( register, ( @registers.get_value( register ).bit_set( bit_to_set ) ))
      # end
      # 
      # def clear_register_bit( register, bit_to_clear )
      #   @registers.set_value( register, ( @registers.get_value( register ).bit_clear( bit_to_clear ) ))
      # end
      
      
    end
  end
end