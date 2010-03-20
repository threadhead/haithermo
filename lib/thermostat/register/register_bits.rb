require 'lib/thermostat/register/fixnum_bits'

module HAIthermo
  module Thermostat
    module RegisterBits
      
      def set_register_bit( value, bit_to_set )
        value.bit_set( bit_to_set )
      end
      
      def clear_register_bit( value, bit_to_clear )
        value.bit_clear( bit_to_clear )
      end      
      
      def get_register_bit( value, bit_to_get )
        value.bit_get( bit_to_get )
      end
      
    end
  end
end