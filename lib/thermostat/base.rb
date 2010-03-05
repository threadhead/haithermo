require 'lib/thermostat/register'
# require 'lib/thermostat/schedule'
# require 'lib/thermostat/timestamp_attribute'
require 'lib/thermostat/display_options'
require 'lib/thermostat/output_status'
require 'lib/thermostat/actions'

module HAIthermo
  module Thermostat
    class BaseError < StandardError; end
  
    class Base
      extend HAIthermo::Thermostat::DisplayOptions
      extend HAIthermo::Thermostat::OutputStatus
      extend HAIthermo::Thermostat::Actions

      attr_reader :registers
      
      def initialize(my_control, thermo_address)
        @my_control = my_control
        @registers = HAIthermo::Thermostat::Register.new( thermo_address )
      end
    
    
      def address
        @registers.get_value(0)
      end
      

      def get_registers_from_thermo(start_register, quantity)
        @my_control.send( PollForRegisters.new( self.address, start_register, quantity ).assemble_packet )
        mf = MessageFactory.new.new_incoming_message( @my_control.read )
        @registers.set_value_range_string(mf.data)
      end
      
      def set_registers_from_thermo(start_register, quantity)
        @my_control.send( SetRegisters.new( self.address,
                            start_register,
                            @registers.get_value_range_string(start_register, quantity)
                            ).assemble_packet )
        
      end
      
     
      
    
      def model_name
        case @registers.get_value( 0x49 )
        when 0 then "RC-80"
        when 1 then "RC-81"
        when 8 then "RC-90"
        when 9 then "RC-91"
        when 16 then "RC-100"
        when 17 then "RC-101"
        when 34 then "RC-112"
        when 48 then "RC-120"
        when 49 then "RC-121"
        when 50 then "RC-122"
        end
      end


    
      def omnistat_to_c(temp_o)
        -40.0 + ( temp_o * 0.5 )
      end

      def c_to_omnistat(temp_c)
        ( temp_c + 40 ) * 2
      end
            
      def f_to_c(temp_f)
        ( temp_f - 32 ) * 5 / 9.0
      end
      
      def c_to_f(temp_c)
        ( 9.0 / 5 * temp_c ) + 32.0
      end

    end
  end
end