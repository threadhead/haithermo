module HAIthermo
  class PollForRegister < Message
    def initialize(thermo_address, first_register, number_of_registers)
      self.super(thermo_address, 0, 0, (first_register.chr + number_of_registers.chr))
    end
  end
end
