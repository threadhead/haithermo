require 'lib/thermostat/register/fixnum_bits'

module HAIthermo
  module Thermostat
    module RegisterBits
      
      def set_register_bit( register, bit_to_set )
        @registers.set_value( register, ( @registers.get_value( register ).bit_set( bit_to_set ) ))
      end
      
      def clear_register_bit( register, bit_to_clear )
        @registers.set_value( register, ( @registers.get_value( register ).bit_clear( bit_to_clear ) ))
      end      
      
      def get_register_bit( register, bit_to_get )
        @registers.get_value( register ).bit_get( bit_to_get )
      end
      
    end
  end
end