module HAIthermo
  module Message

    class PollForRegisters < Base
      def initialize(thermo_address, first_register, number_of_registers)
        raise "number of registers must be 1..14" if (number_of_registers > 14 || number_of_registers < 1) 

        message_type = 0
        super(thermo_address, 'host', message_type, (first_register.chr + number_of_registers.chr))
      end
    end
    
  end
end
