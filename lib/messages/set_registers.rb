module HAIthermo
  class SetRegisters < Message::Base
    def initialize(thermo_address, start_register, data_bytes)
      message_type = 1
      super(thermo_address, 'host', message_type, (start_register.chr + data_bytes))
    end
  end
end
