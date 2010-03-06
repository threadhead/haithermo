%w(register display_options output_status actions).each do |file|
  require File.join(File.dirname(__FILE__), "#{file}")
end


module HAIthermo
  module Thermostat
    class BaseError < StandardError; end
  
    class Base
      attr_reader :registers

      extend HAIthermo::Thermostat::DisplayOptions
      extend HAIthermo::Thermostat::OutputStatus
      include HAIthermo::Thermostat::Actions

      
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
        @registers.set_value_range_string(mf.data) if mf
      end
      
      def set_registers_from_thermo(start_register, quantity)
        @my_control.send( SetRegisters.new( self.address,
                            start_register,
                            @registers.get_value_range_string(start_register, quantity)
                            ).assemble_packet )
        mf = MessageFactory.new.new_incoming_message( @my_control.read )
        # should get back an ACK
        # @registers.set_value_range_string(mf.data) if mf
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
        (( temp_c + 40 ) * 2).to_i
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