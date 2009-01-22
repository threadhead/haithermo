module HAIthermo
  class SetRegisters < Message
    def initialize(thermo_address, start_registers, data_bytes)
      self.super(thermo_address, 0, 1, (first_register.chr + number_of_registers.chr))
    end
  end
end
