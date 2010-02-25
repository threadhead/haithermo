module HAIthermo
  class ReceiveNACK < Message::Base
    def initialize(thermo_address)
      message_type = 1
      super(thermo_address, 'reply', message_type, '')
    end
  end
end
