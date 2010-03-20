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
        packet = PollForRegisters.new( self.address.value, start_register, quantity )
        message = @my_control.send_packet( packet )
        
        @registers.set_value_range_string(message.data) if message
      end
      
      
      def set_registers_from_thermo(start_register, quantity)
        packet = SetRegisters.new( self.address.value,
                            start_register,
                            @registers.get_value_range_string(start_register, quantity))
        message = @my_control.send_packet( packet )
        # should get back an ACK
      end
      

    end
  end
end