%w(register registers actions).each do |file|
  require File.join(File.dirname(__FILE__), "#{file}")
end


module HAIthermo
  module Thermostat
    class BaseError < StandardError; end
  
    class Base
      attr_reader :registers, :name

      include HAIthermo::Thermostat::Actions
      
      def initialize(my_control, thermo_address, name)
        extend HAIthermo::Thermostat::Registers
        @my_control = my_control
        @name = name
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
      end
      

    end
  end
end