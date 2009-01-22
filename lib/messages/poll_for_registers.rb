module HAIthermo
  class PollForRegisters < Message
    def initialize(thermo_address, first_register, number_of_registers)
      self.super(thermo_address, 0, 0, (first_register.chr + number_of_registers.chr))
      @host_or_reply = 0
      @message_type = 0
    end
  end
end
